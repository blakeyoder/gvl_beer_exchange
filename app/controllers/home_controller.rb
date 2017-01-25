class HomeController < ApplicationController
    before_filter :disable_cart_partial
    def home
    	untappd = Untappd.new
        @events = untappd.get_events(2652)
        @beers = untappd.get_list(17868)
    end
    
end