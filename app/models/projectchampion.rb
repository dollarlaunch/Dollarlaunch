class Projectchampion < ApplicationRecord
  
  belongs_to :campaign
  belongs_to :user

  def paypal_url(return_path)
    logger.info "PAYPAL #{self.id}"
    values = {
      business: "#{ENV['business']}",
      cmd: "_xclick",
      upload: 1,
      return: "#{ENV['app_host']}#{return_path}",
      invoice: self.id,
      amount: self.projectchampionpaidamount,
      item_name: self.campaign.title,
      item_number: self.id,
      quantity: '1',
      notify_url: "#{ENV['app_host']}/hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end
  
end