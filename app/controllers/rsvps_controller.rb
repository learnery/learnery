class RsvpsController < ApplicationController

  def create
    @event = Event.find( params[:rsvp][:event_id] )
    @rsvp = current_user.rsvp.build( rsvp_params )

    if @rsvp.save
      redirect_to @event, notice: 'rsvp saved.'
    else
      redirect_to @event, notice: 'rsvp could not be saved.'
    end
  end

  def update
    @rsvp = Rsvp.find( params[:id] )
    if @rsvp.update_attributes( rsvp_params )
      redirect_to @rsvp.event, notice: 'rsvp saved.'
    else
      redirect_to @rsvp.event, notice: 'rsvp could not be saved.'
    end
  end

private

  def rsvp_params
    params.require(:rsvp).permit(:answer, :event_id)
  end
end
