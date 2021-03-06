class Ability
  
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :new, Campaign
      can :update, Campaign do |campaign|
        campaign.user == user or (campaign.user.referalcode  == user.referby and campaign.invites.each { |invite| invite.user == user })
      end
      can :destroy, Campaign do |campaingn|
        campaingn.user == user
      end
      can :update, Comment do |comment|
        comment.user == user
      end
      can :destroy, Comment do |comment|
        comment.user == user
      end
      can :destroy, Milestoneupdate do |milestoneupdate|
        milestoneupdate.milestone.campaign.user == user
      end
      can :read, :all
      cannot :index, Category
      cannot :index, Badge
      cannot :show, Badge
      cannot :read, Campaign, status: 'Draft'
      can :read, Campaign, status: 'Draft', user_id: user.id
    end
    
  end
  
end