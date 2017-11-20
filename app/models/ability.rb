class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    else
      can :read, :all
    end

    can :manage, Event do |event|
      event.user == user
    end
  end
end
