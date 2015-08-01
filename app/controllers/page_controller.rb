class PageController < ApplicationController

  def index
    @categories = Category.all
  end

end
