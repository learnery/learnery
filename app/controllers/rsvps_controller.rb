class RsvpsController < ApplicationController

  def create
    @event = Event.find( params[:rsvp][:event_id] )
    @rsvp = @event.rsvp_build( current_user )

    if @rsvp.save
      redirect_to @event, notice: 'rsvp saved.'
    else
      redirect_to @event, notice: 'rsvp could not be saved.'
    end
  end

  def update
    @rsvp = Rsvp.find( params[:id] )

    if @rsvp.send rsvp_params[:event]
      redirect_to @rsvp.event, notice: 'success'
    else
      redirect_to @rsvp.event, notice: 'could not be saved.'
    end
  end

private

  def rsvp_params
    params.require(:rsvp).permit(:event)
  end
end
