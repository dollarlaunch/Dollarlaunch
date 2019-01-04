require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class MilestoneupdatesController < ApplicationController
  
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_user!
  load_and_authorize_resource only:[:destroy]
  
  def create
    @milestoneupdate = Milestoneupdate.new(milestoneupdate_params)
    respond_to do |format|
      if @milestoneupdate.save
        format.html { 
          @milestone = @milestoneupdate.milestone.id
          @campaign = @milestoneupdate.milestone.campaign
          @milestones = @campaign.milestones
          @milestones.each do |milestone|
            if milestone.id == @milestone
              takepaymentsfrombackers
              milestone.update_attributes(status: 1)
              redirect_to @campaign
            end
          end
        }
        format.js
      else
        format.html { render :new }
      end
    end
  end
  
  private
    def milestoneupdate_params
      params.require(:milestoneupdate).permit(:body, :milestone_id)
    end
    
    def takepaymentsfrombackers
      @campaign = @milestoneupdate.milestone.campaign
      @backers = @campaign.backers
      @backers.each do |backer|
        @pledgeamountperpersoninstring = backer.pledgeamountperperson
        @pledgeamountperperson = @pledgeamountperpersoninstring.to_i
        @milestones = @campaign.milestones.count
        @eachmilestoneamount = @pledgeamountperperson/@milestones
        if @campaign.milestones.count == 1
          @eachmilestoneamount = @eachmilestoneamount - 1
        end
        @milestoneamount = number_with_precision(@eachmilestoneamount, precision: 2)
        @auth_id = backer.authorization
        @authorization = Authorization.find(@auth_id)
        capture = @authorization.capture({
          :amount => {
            :currency => "USD",
            :total => @milestoneamount
          },
          :is_final_capture => false
        })
        if capture.success?
          logger.info "Capture[#{capture.id}]"
          Backerinvoice.create!(amount: capture.amount.total, captureid: capture.id ,backer_id: backer.id)
          UsermailerMailer.milestonecompletion_email(backer.user, capture.amount.total, backer.campaign.title).deliver
          @a = backer.user.userbadges.where(badge_id: 7)
          if !@a.present?
            Userbadge.create!(user_id: backer.user.id, badge_id: 7)
          end
        else
          logger.error capture.error.inspect
        end
        # if @authorization.reauthorize # Return true or false
        #   logger.info "Reauthorization[#{@authorization.id}]"
        # else
        #   logger.error @authorization.error.inspect
        # end
      end
    end
end
