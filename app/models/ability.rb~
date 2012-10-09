class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user

    if !user.email.nil?
       if user.admin?
           can :manage, :all
       else
           can :read, :all
           can :videos, Channel
           can :new, Channel
           can :create, Channel
           can :update, Channel do |channel|
               channel.try(:user) == user
           end
           can :destroy, Channel do |channel|
               channel.try(:user) == user
           end
           can :new, Feed
           can :create, Feed
           can :update, Feed
           can :destroy, Feed

           ##can :update, Article do |article|
           ##  article.try(:user) == user
           ##end
           
           can :new, User
           can :create, User
           can :update, User do |theuser|
                theuser == user
           end
           can :sign_in, User
           can :sign_out, User
           can :channels, User
           ###can :index, User
       end
    else
       can :read, :all
       can :new, User
       can :create, User
       can :sign_in, User
       ###can :index, User
    end
  end  
end
