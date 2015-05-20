class Songkick


  def self.city_search_by_string query
    response = HTTParty.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{query}&apikey=#{ENV["SONGKICK_KEY"]}")
  end

private

  def clean_city_results results
    
  end
  
end
