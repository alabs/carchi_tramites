class PageController < ApplicationController

  def ayuda
  end

  def noticias
    url = "https://gobiernoabierto.carchi.gob.ec/es/news.rss"
    feed = Feedjira::Feed.fetch_and_parse url
    @entries = feed.entries
  end

  def index
    @events = Event.all
    @no_layout = true
  end

  def juventud
    url = "https://gobiernoabierto.carchi.gob.ec/es/areas/7/news.rss"
    feed = Feedjira::Feed.fetch_and_parse url
    @entries = feed.entries[0..1] # only 2 posts from RSS
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
