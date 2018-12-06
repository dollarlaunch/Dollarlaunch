require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class UsersController < ApplicationController
  
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_admin, only: [:index]
  before_action :set_user, only: [:dashboard, :profile]
  load_and_authorize_resource except: [:dashboard, :profile, :change_milestone_status]
  
  def index
    @users = User.all
  end
  
  def dashboard
    if current_user.admin != true
      @campaigns = current_user.campaigns.limit(3)
    else
      @campaigns = Campaign.limit(1)
    end
  end
  
  def profile
  end
  
  def change_milestone_status
    if params[:milestone].present?
      @milestoneinstring = params[:milestone]
      @milestone = @milestoneinstring.to_i
      @campaign = Campaign.find(params[:id])
      @milestones = @campaign.milestones
      @milestones.each do |milestone|
        if milestone.id == @milestone
          takepaymentsfrombackers
          milestone.update_attributes(status: 1)
          redirect_to @campaign
        end
      end
    end
  end
  
  private
  
    def takepaymentsfrombackers
      @campaign = Campaign.find(params[:id])
      @backers = @campaign.backers
      @backers.each do |backer|
        @pledgeamountperpersoninstring = backer.pledgeamountperperson
        @pledgeamountperperson = @pledgeamountperpersoninstring.to_i
        @milestones = @campaign.milestones.count
        @eachmilestoneamount = @pledgeamountperperson/@milestones
        @milestoneamount = number_with_precision(@eachmilestoneamount, precision: 2)
        @auth_id = backer.authorization
        @authorization = Authorization.find(@auth_id)
        capture = @authorization.capture({
          :amount => {
            :currency => "USD",
            :total => @eachmilestoneamount
          },
          :is_final_capture => false
        })
        if capture.success?
          logger.info "Capture[#{capture.id}]"
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
  
    def authenticate_admin
      authorize_admin
    end
    
    def set_user
      @user = current_user
    end
    
end