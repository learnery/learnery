  module Learnery
    module RsvpHelper

    def rsvp_type_options
      #                      Learnery::OpenRsvp -->  learnery/openrsvp  --> I18n
      Rsvp.implementations.map(&:to_s).map{|x| y = x.to_s.gsub(/Learnery::/, 'learnery/'); [I18n.t("#{y}", :scope => 'activerecord.models'),y]}
    end

    def rsvp_options(o)
      o.class.state_machines[:answer].states.map(&:name).map{|x|[t(x, :scope => 'activerecord.attributes.learnery/rsvp.answer'),x]}
    end

    def event_rsvp_numbers
      all = case @event.count_yes
        when 0 then t :rsvp_0
        when 1 then t :rsvp_1
        else        t :rsvp_n, :count => @event.count_yes
      end

      if @rsvp && @rsvp.has_waitlist?
        all = all + t(:there_are_no_people_on_waitlist, :number => @rsvp.no_on_waitlist) + ". "
      end
      all
    end

    def event_rsvp_list_names
      @event.users_who_rsvped_yes.map{ |u| u.nickname }.join(", ")
    end

    def event_type_explanation( event_type )
      t(event_type.to_s, :scope => 'activerecord.values.event.type' )
    end

    def event_rsvp_type_explanation( rsvp_type )
      t(rsvp_type.to_s, :scope => 'activerecord.values.event.rsvp_type' )
    end

    def current_rsvp_status
      return t(:to_rsvp_please_login) + "." if @rsvp.nil?
      t(@rsvp.answer, :scope => 'rsvp_describe_answer_for_you') + "."
    end

  end
end
