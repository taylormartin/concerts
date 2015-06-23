class Songkick

  def self.city_search_by_string query
    response = HTTParty.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{query}&apikey=#{ENV["SONGKICK_KEY"]}")
    search_results = clean_city_results(response)
  end

private

  #TODO: this will need to make this safe for a no results found on city search
  def self.clean_city_results results
    array = []
    entries = results["resultsPage"]["results"]["location"]
    entries.each do |entry|
      state_name = entry["city"]["state"]["displayName"]
      city_name = entry["city"]["displayName"]
      metro_id = entry["metroArea"]["id"]
      array << {city: city_name, state: state_name, metro_id: metro_id}
    end
    array
  end
  
end
