class HomeController < ApplicationController

  def index
    # hard coding "atlanta" in for now to get the data right
    Songkick.city_search_by_string "atlanta"
  end


end
