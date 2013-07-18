# This migration comes from learnery (originally 20130717064307)
class DropRsvpTypeFromEvent < ActiveRecord::Migration
  def up
    remove_column :learnery_events, :rsvp_type
  end

  def down
    add_column :learnery_events, :rsvp_type, :string, default: "Learnery::OpenRsvp", null: false
    execute "UPDATE learnery_events SET rsvp_type = 'Learnery::OpenRsvp'          WHERE type='Learnery::Event'                "
    execute "UPDATE learnery_events SET rsvp_type = 'Learnery::OpenRsvp'          WHERE type='Learnery::OpenEvent'            "
    execute "UPDATE learnery_events SET rsvp_type = 'Learnery::RsvpWithWaitlist'  WHERE type='Learnery::EventWithWaitlist'    "
    execute "UPDATE learnery_events SET rsvp_type = 'Learnery::ApplyForRsvp'      WHERE type='Learnery::EventWithApplication' "
  end
end
