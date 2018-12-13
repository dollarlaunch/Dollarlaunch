require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class BackersController < ApplicationController
  
  def create
    @backer = Backer.new(backer_params)
    # Setting up the authorization information object for the Payment of the Backer.
    @payment = Payment.new({
      :intent =>  "authorize",
      # Set payment type
      :payer =>  {
        :payment_method =>  "paypal"
      },
      # Set redirect urls
      :redirect_urls => {
        :return_url => "#{ENV['app_host']}/campaigns/#{@backer.campaign_id}",
        :cancel_url => "#{ENV['paypal_host']}"
      },
      # Set transaction object
      :transactions =>  [{
        # Items
        :item_list => {
          :items => [{
            :name => @backer.campaign.title,
            :sku => "item",
            :price => @backer.pledgeamountperperson,
            :currency => "USD",
            :quantity => 1
          }]
        },
        # Amount - must match item list breakdown price
        :amount =>  {
          :total =>  @backer.pledgeamountperperson,
          :currency =>  "USD"
        },
        :description =>  @backer.id
      }]
    })
    # Initialize the authorization and redirect the user
    if @payment.create
    # Redirect the user to given approval url
      @redirect_url = @payment.links.find{|v| v.rel == "approval_url" }.href
      redirect_to @redirect_url
    else
      logger.error @payment.error.inspect
    end
  end
  
  private
    
    def backer_params
      params.require(:backer).permit(:user_id, :campaign_id, :pledgeamountperperson)
    end
    
end