class StaticPagesController < ApplicationController

    def landing
        render layout: "landing_layout"
    end
    
end
