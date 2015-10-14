class PageController < ApplicationController

  def index
    @events = Event.all
    @no_layout = true
  end

  def juventud
    @events = Event.type_activities
  end

  def audiencia
    redirect_to_event Event.type_audience.first
  end

  def medio_ambiente
    redirect_to_event Event.type_trees.first
  end

  private

  def redirect_to_event event
    url = event ? new_inscription_url(event_id: event) : root_path
    redirect_to url
  end

end
