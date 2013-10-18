module Learnery
  class Event < ActiveRecord::Base
    # Every event has a name and start time

    validates :name, :starts, :type, :presence => true
    validate :validate_starts_before_it_ends
    validate :validate_topics_enabled_if_topics_present

    def validate_topics_enabled_if_topics_present
      if topics.present?
        errors.add(:topics_enabled, I18n.t(:not_allowed_to_disable_topics_if_topics_present, :scope => 'errors.messages')) unless topics_enabled?
      end
    end

    def validate_starts_before_it_ends
      if ends && starts
        errors.add(:ends, I18n.t(:starts_must_be_before_ends, :scope => 'errors.messages')) if ends <= starts
      end
    end

    # this class knows about its subclasses
    # and about the corresponding subclasses of rsvp.
    # TODO: can we remove this knowledge?

    @@map_event_type_to_rsvp_type = {  "Learnery::OpenEvent"            => "Learnery::OpenRsvp",  
                                       "Learnery::EventWithWaitlist"    => "Learnery::RsvpWithWaitlist", 
                                       "Learnery::EventWithApplication" => "Learnery::ApplyForRsvp"      }
    def self.implementations
        [ OpenEvent, EventWithWaitlist, EventWithApplication ]
    end


    # ----------- concerning rsvps ----------
    # Users can rsvp for events
    # this is actually always
    has_many :rsvp
    has_many :users, :through => :rsvp
    # ----------- /concerning rsvps ----------

    # you can find the future and past events by start time with Event.future and Event.past


    default_scope { order(:starts) }

    scope :future, -> { where( "starts >= ?", Time.zone.now ) }
    scope :past, -> { where( "starts < ?", Time.zone.now ) }

    has_many :topics

    def suggested_topics
      topics
    end

    def topics_enabled?
      topics_enabled
    end

    def has_waitlist?
      false
    end
    def places_available?
      true
    end


    # ----------- concerning rsvps ----------

    # can count rsvps or access them
    def count_rsvps
      rsvp.count
    end

    def may_change_type?
      rsvp.count == 0
    end

    # can count types of rspvs
    def count_rsvps_by_type
      h = {}
      # todo strange dependency to Event, remove sql!
      Learnery::Event.connection.select_all("SELECT answer, count(id) FROM learnery_rsvps WHERE event_id=#{id} GROUP BY answer").to_a.map{|h| h.map{|k,v| v} }.each{|x| h[x[0].to_sym] = x[1] }
      h
    end

    def users_who_rsvped
      rsvp.map(&:user)
    end

    # can count users with rsvp answer
    def count_rsvps_with_answer(answer)
      rsvp.where(:answer => answer).count
    end
    def users_who_rsvped_with(answer)
      rsvp.where(:answer => answer)
    end

    # can count users who rsvped yes,  or access them
    def count_yes
      rsvp.yes.count
    end
    def users_who_rsvped_yes
      rsvp.yes.map(&:user)
    end

    # can count users who rsvped no,  or access them
    def count_no
      rsvp.no.count
    end
    def users_who_rsvped_no
      rsvp.no.map(&:user)
    end

    # can count users who rsvped maybe,  or access them
    def count_maybe
      rsvp.maybe.count
    end
    def users_who_rsvped_maybe
      rsvp.maybe.map(&:user)
    end

    # get rsvp of this user
    def rsvp_of(user)
      rsvp.where(:user => user).first
    end

    def rsvp_type_for_me
      @@map_event_type_to_rsvp_type[ self.class.to_s ].constantize
    end

    def rsvp_new( user )
      rsvp_type = rsvp_type_for_me
      rsvp_type.new( event: self , user: user )
    end
    def rsvp_create!( user )
      rsvp_type = rsvp_type_for_me
      rsvp_type.create!( event: self, user: user )
    end
    # /----------- concerning rsvps ----------
  end
end
