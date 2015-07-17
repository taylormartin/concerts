class Songkick

#TODO: need to create @base_uri variable for API calls
#TODO: do a global self up top since all of this will probably be self methods 

  def self.city_search_with_string query
    response = HTTParty.get("http://api.songkick.com/api/3.0/search/locations.json?query=#{query}&apikey=#{ENV["SONGKICK_KEY"]}")
    cities = transform_city_results(response)
  end

  def self.concert_search_with_metro_id_and_dates metro_id, start_date, end_date
    response = HTTParty.get("http://api.songkick.com/api/3.0/events.json?apikey=#{ENV["SONGKICK_KEY"]}&location=sk:#{metro_id}&min_date=#{start_date}&max_date=#{end_date}")
    concerts_venues = get_all_events_and_venues(response, metro_id, start_date, end_date)
  end

private

  #TODO: this will need to be safe for a no results found on city search
  def self.transform_city_results response
    cities_array = []
    entries = response["resultsPage"]["results"]["location"]
    entries.each do |entry|
      state_name = entry["city"]["state"]["displayName"]
      city_name = entry["city"]["displayName"]
      metro_id = entry["metroArea"]["id"]
      cities_array << {city: city_name, state: state_name, metro_id: metro_id}
    end
    cities_array
  end


  def self.get_all_events_and_venues response, metro_id, start_date, end_date
    events_package = []

    per_page = response['resultsPage']['perPage']
    page_num = response['resultsPage']['page']
    total_entries = response['resultsPage']['totalEntries']
    total_pages = (total_entries.to_f / per_page.to_f).ceil
    additional_calls = total_pages - page_num

    while page_num <= total_pages do
      events_package << response['resultsPage']['results']['event']
      page_num += 1
      if additional_calls > 0
        response = HTTParty.get("http://api.songkick.com/api/3.0/events.json?apikey=#{ENV["SONGKICK_KEY"]}&location=sk:#{metro_id}&min_date=#{start_date}&max_date=#{end_date}&page=#{page_num}")
        additional_calls = additional_calls - 1
      end
    end

    transformed_events = transform_events(events_package)
  end

  #TODO: need to add in a way to handle festivals
  def self.transform_events events
    concert_package = {'concerts' => [], 'venues' => []}

    events.flatten.each do |event|
      event_hash = {}
      if event['type'] == 'Concert'
        event_hash['artist_name'] = event['performance'][0]['displayName']
        event_hash['venue_name'] = event['venue']['displayName']
        event_hash['date'] = event['start']['date']
        event_hash['link'] = event['uri']
        concert_package['concerts'] << event_hash
        concert_package['venues'] << event_hash['venue_name']
      end
    end

    concert_package['venues'] = concert_package['venues'].uniq
    
    concert_package
  end

end
