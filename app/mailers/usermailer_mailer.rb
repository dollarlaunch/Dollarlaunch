class UsermailerMailer < ApplicationMailer
  
  default from: 'support@dollarmark.com'
  
  def welcome_email(user)
    @user = user
    @url = 'http://kickstarter-mhamzajutt96.c9users.io'
    mail(to: @user.email, subject: "Welcome to DollarMark Website, Your Account has been Confirmed")
  end
  
end
