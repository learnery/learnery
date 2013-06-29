module Learnery
  class EventsController < ApplicationController
    include Learnery::AuthenticationHelper
    include Learnery::RsvpHelper
    before_action :set_event, only: [:show, :edit, :update, :destroy]
    before_filter :admin_only,  :only => [ :new, :edit, :create, :update, :destroy ]

    # `GET /events`            shows future events in @events, the next event is featured as @event
    # `GET /events?past=true`  shows past events in @events
    def index
      if params[:past] == "true" then
        @events = Event.past
        render "past"
      else
        @events = Event.future
        if @events.count > 0 then
          @event = @events.shift
          @rsvp = @event.rsvp_of( current_user ) || @event.rsvp_new( current_user ) if current_user
        end
        render "index"
      end
    end

    # GET /events/1
    # GET /events/1.json
    def show
      @rsvp = @event.rsvp_of( current_user ) || @event.rsvp_new( current_user ) if current_user
    end

    # GET /events/new
    def new
      @event = Event.new
    end

    # GET /events/1/edit
    def edit
    end

    # POST /events
    # POST /events.json
    def create
      @event = Event.new(event_params)

      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Event was successfully created.' }
          format.json { render action: 'show', status: :created, location: @event }
        else
          format.html { render action: 'new' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /events/1
    # PATCH/PUT /events/1.json
    def update
      respond_to do |format|
        if @event.update(event_params)
          format.html { redirect_to @event, notice: 'Event was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def event_params
        params.require(:event).permit(:name, :starts, :ends, :venue, :description, :rsvp_type, :max_attendees, :event)
      end

  end
end
