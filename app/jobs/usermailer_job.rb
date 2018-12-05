class UsermailerJob < ApplicationJob
  
  queue_as :default

  def perform(user)
    UsermailerMailer.informationaboutsite_email(user).deliver_later(wait_until: 4.minutes.from_now)
  end
  
end
