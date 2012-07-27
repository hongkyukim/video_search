class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user

    if !user.email.nil?
       if user.admin?
           can :manage, :all
       elsif !user.admin?
          can :manage, :all
       else
           can :read, :all
           can :videos, Channel
           can :create, Channel
           can :update, Channel do |channel|
               true ##channel.try(:user) == user
           end
           can :create, Feed
           can :update, Feed

           ##can :update, Article do |article|
           ##  article.try(:user) == user
           ##end

       end
    else
       can :read, :all
    end
  end  
end
