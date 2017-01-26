require 'httparty'
require 'hashie'
require 'rest-client'
require 'digest/md5'
require 'json'
require 'ostruct'

class Untappd
  include HTTParty
  @@base_uri = "https://business.untappd.com/api/v1"
  format :json

  def self.response_to_mash(response)
    if response.code == 200
      Hashie::Mash.new(response).response
    else
      Hashie::Mash.new {}
    end
  end

  def get_list(menu_id)
    response = RestClient::Request.execute method: :get, url: @@base_uri + "/sections/#{menu_id}/items", user: ENV['UNTAPPD_EMAIL'], password: ENV['UNTAPPD_PASSWORD']
    response = JSON.parse(response)
  end

  def get_events(location_id)
    response = RestClient::Request.execute method: :get, url: @@base_uri + "/locations/#{location_id}/events", user: ENV['UNTAPPD_EMAIL'], password: ENV['UNTAPPD_PASSWORD']
    response = JSON.parse(response)
    results = []
    response["events"].each do |hash|
      results << hash if hash["start_time"] > (Time.now + 2*60*60) # 2 hour buffer period
    end
    return results
  end
end