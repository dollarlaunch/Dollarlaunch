class UsermailerMailer < ApplicationMailer
  
  default from: 'support@dollarmark.com'
  
  def welcome_email(user)
    @user = user
    @url = 'http://kickstarter-mhamzajutt96.c9users.io'
    mail(to: @user.email, subject: "Welcome to DollarMark Website, Your Account has been Confirmed")
  end
  
  def informationaboutsite_email(user)
    @user = user
    @url = 'http://kickstarter-mhamzajutt96.c9users.io'
    mail(to: @user.email, subject: "Welcome to DollarMark Website, This Website is for Open Source Projects")
  end
  
  def milestonecompletion_email(user, amount, title)
    @user = user
    @amount = amount
    @title = title
    @url = 'http://kickstarter-mhamzajutt96.c9users.io'
    mail(to: @user.email, subject: "Congratulations! Milestone is Completed")
  end
  
end