class HomeController < ApplicationController

  def index
    # hard coding "atlanta" in for now to get the data right
    #results = Songkick.city_search_with_string "atlanta"
    #results.to_json
    
    # hard coding the ATL id for now to work on transform method
    #results = Songkick.concert_search_with_metro_id_and_dates 4120, "2015-08-30", "2015-12-31"
    #resutls.to_json
  end

end
