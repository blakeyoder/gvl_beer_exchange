class EventsController < ApplicationController

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :date, :time, :description)
    end
end
