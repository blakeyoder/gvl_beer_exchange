class HomeController < ApplicationController
    before_filter :disable_cart_partial
    def home
        @events = Event.all
    end
    
end