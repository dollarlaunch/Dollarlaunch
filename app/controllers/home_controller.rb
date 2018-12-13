class HomeController < ApplicationController
  
  def index
    @campaigns = Campaign.where(status: 1)
  end
  
end