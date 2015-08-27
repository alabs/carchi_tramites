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
      can :manage, Plant
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    elsif user.audiencia?
      can :manage, Inscription, event: {ttype: 2}
      can :manage, Slot
      can :read, ActiveAdmin::Page, :name => "Calendario"
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    elsif user.actividad?
      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can :manage, Inscription, event: {ttype: 1}
    else
      #can :manage, :all
      cannot :read, :all
      can :read, ActiveAdmin::Page, :name => "Dashboard"
    end
  end

end
