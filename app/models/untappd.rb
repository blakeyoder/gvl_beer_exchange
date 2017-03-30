require 'hashie'
require 'rest-client'
require 'digest/md5'
require 'json'
require 'ostruct'

class Untappd
  @@base_uri = "https://business.untappd.com/api/v1"

  def self.response_to_mash(response)
    if response.code == 200
      Hashie::Mash.new(response).response
    else
      Hashie::Mash.new {}
    end
  end

  def self.cache_request(menu_id)
    Rails.cache.fetch "items", :expires_in => 1.hour do
      response = RestClient::Request.execute method: :get, url: @@base_uri + "/sections/#{menu_id}/items", user: ENV['UNTAPPD_EMAIL'], password: ENV['UNTAPPD_PASSWORD']
      response = JSON.parse(response)
    end
  end

  def self.cache_events(location_id)
    Rails.cache.fetch "events", :expires_in => 30.minutes do
        response = RestClient::Request.execute method: :get, url: @@base_uri + "/locations/#{location_id}/events", user: ENV['UNTAPPD_EMAIL'], password: ENV['UNTAPPD_PASSWORD']
        response = JSON.parse(response)
        results = []
        response["events"].each do |hash|
          results << hash if hash["start_time"] > (Time.now + 2*120) #buffer period
        end
        return results
    end
  end
end
