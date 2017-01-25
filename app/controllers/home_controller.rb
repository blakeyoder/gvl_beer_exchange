class HomeController < ApplicationController
    before_filter :disable_cart_partial
    def home
        @events = Event.all
        @untappd = Untappd.new.get_list(17868)
        # @beers = @untappd.get_list(17868)
    end
    
end