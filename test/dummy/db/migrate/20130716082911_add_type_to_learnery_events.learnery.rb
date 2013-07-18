# This migration comes from learnery (originally 20130716062520)
class AddTypeToLearneryEvents < ActiveRecord::Migration
  def change
    add_column :learnery_events, :type, :string
    execute "UPDATE learnery_events SET type='Learnery::Event'                WHERE rsvp_type = 'Learnery::OpenRsvp'         "
    execute "UPDATE learnery_events SET type='Learnery::EventWithWaitlist'    WHERE rsvp_type = 'Learnery::RsvpWithWaitlist' "
    execute "UPDATE learnery_events SET type='Learnery::EventWithApplication' WHERE rsvp_type = 'Learnery::ApplyForRsvp'     "
  end
end
