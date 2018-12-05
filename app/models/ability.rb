class Ability
  
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      cannot :new, Campaign
    else
      can :new, Campaign
      can :update, Campaign do |campaign|
        campaign.user == user
      end
      can :destroy, Campaign do |campaingn|
        campaingn.user == user
      end
      can :read, :all
    end
    
  end
  
end