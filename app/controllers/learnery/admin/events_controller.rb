module Learnery
module Admin
  class EventsController < ApplicationController
    include Learnery::AuthenticationHelper
    before_action :set_event, only: [:show, :destroy]
    before_filter :admin_only

    # `GET /events`            shows future events in @events, the next event is featured as @event
    # `GET /events?past=true`  shows past events in @events
    def index
      @events = Learnery::Event.all
    end

    # GET /events/1
    # GET /events/1.json
    def show
      @rsvps = @event.rsvp.includes(:user)
    end

    # DELETE /events/1.json
    def destroy
      @event.destroy
      respond_to do |format|
        format.html { redirect_to events_url }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Learnery::Event.find(params[:id])
    end

  end
end
end
