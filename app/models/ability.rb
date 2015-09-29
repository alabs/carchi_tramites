class Ability

  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    #
    user ||= AdminUser.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.plantas?
      can :manage, Inscription, event: {ttype: 3}
      can [:read, :update], Email, event: {ttype: 3}
      can [:read, :update], Event, ttype: 3
      can [:read, :create, :update], Plant
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    elsif user.audiencia?
      can :manage, Inscription, event: {ttype: 2}
      can [:read, :update], Event, ttype: 2
      can [:read, :update], Email, event: {ttype: 2}
      can :manage, Slot
      can :read, ActiveAdmin::Page, :name => "Calendario"
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    elsif user.actividad?
      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can [:read, :create, :update], Institute
      can [:read, :create, :update], Instructor
      can :manage, Inscription, event: {ttype: 1}
      can [:read, :update], Email, event: {ttype: 1}
      can [:read, :create, :update], Event, ttype: 1
    else
      #can :manage, :all
      cannot :read, :all
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    end
  end

end
