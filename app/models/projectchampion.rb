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
      invoice: self.createinvoicecode,
      amount: self.projectchampionpaidamount,
      item_name: self.campaign.title,
      item_number: self.id,
      quantity: '1',
      notify_url: "#{ENV['app_host']}/hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end
  
  
  def createinvoicecode
    @amount = self.projectchampionpaidamount
    @amount = SecureRandom.urlsafe_base64(8)
    return @amount
  end
    
end