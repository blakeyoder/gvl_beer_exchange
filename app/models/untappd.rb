require 'httparty'
require 'hashie'
require 'digest/md5'

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
    response = response_to_mash HTTParty.get("/sections/#{menu_id}/items", :basic_auth => auth)
  end
end