class AddApplicationDateToEvent < ActiveRecord::Migration
  def change
    add_column :learnery_events, :application_date, :datetime
  end
end
