class PageController < ApplicationController

  def index
    @events = Event.all
    @categories = Category.all
    @no_layout = true
  end

  def audiencia
  end

  def certificado
  end

  def juventud
  end

  def medio_ambiente
  end

end
