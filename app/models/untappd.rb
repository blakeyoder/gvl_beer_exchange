require 'httparty'
require 'hashie'
require 'rest-client'
require 'digest/md5'
require 'json'
require 'ostruct'

class Untappd
  include HTTParty
  base_uri = "https://business.untappd.com/api/v1"
  format :json

  def self.response_to_mash(response)
    if response.code == 200
      Hashie::Mash.new(response).response
    else
      Hashie::Mash.new {}
    end
  end

  def get_list(menu_id, options={})
    auth = {:username => Rails.application.secrets.UNTAPPD_EMAIL, :password => Rails.application.secrets.UNTAPPD_PASSWORD}
    response = RestClient::Request.execute method: :get, url: "https://business.untappd.com/api/v1/sections/#{menu_id}/items", user: ENV['UNTAPPD_EMAIL'], password: ENV['UNTAPPD_PASSWORD']
    response = JSON.parse(response)
  end
end