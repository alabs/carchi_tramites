class PageController < ApplicationController

  def index
    @events = Event.all
    @categories = Category.all
    @no_layout = true
  end

  def audiencia
    ev_audie = Event.type_audience.first
    if ev_audie
      redirect_to new_inscription_url(event_id: ev_audie)
    else
      redirect_to root_path
    end 
  end

  def juventud
  end

  def medio_ambiente
    ev_trees = Event.type_trees.first
    if ev_trees
      redirect_to new_inscription_url(event_id: ev_trees)
    else
      redirect_to root_path
    end 
  end

end
