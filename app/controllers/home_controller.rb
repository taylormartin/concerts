class HomeController < ApplicationController

  def index
    # hard coding "atlanta" in for now to get the data right
    results = Songkick.city_search_by_string "atlanta"
    results.to_json
  end

end
