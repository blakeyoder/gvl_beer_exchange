class HomeController < ApplicationController
    before_filter :disable_cart_partial
    def home
        @events = Event.all
        @beers = Untappd.new.get_list(17868)
    end
    
end