class HomeController < ApplicationController
    before_filter :disable_cart_partial
    def home
        # hardcoded values passed in from client credentials
        @events = Untappd.cache_events(2652)
        @beers = Untappd.cache_request(17868)
    end

end
