
module ApplicationHelper
  include Learnery::FormHelper
  include Learnery::AuthenticationHelper
  include Learnery::RsvpHelper

  def model_errors(model)
    flash_messages = []
    if model.errors.none?
      return ""
    else
      header = t('errors.template.header',  :count => model.errors.count, :model => @user.class)
      #"There was #{pluralize(model.errors.count, "problem")} saving this #{model.class}:"
      flash_messages << header
      model.errors.full_messages.each do |message|
        flash_messages << message
      end
    end
    text = flash_messages.join("<br/>").html_safe
    text = content_tag(:div,
                           content_tag(:button, raw("  &times;"), :class => "close",   "data-dismiss" => "alert") +
                         text.html_safe, :class => "alert fade in alert-error")
  end

  # convert markup to html
  def md(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {filter_html: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    redcarpet.render(text).html_safe
  end

  def rsvp_type_options
    Learnery::Rsvp.implementations.map(&:to_s).map{|x|[t(x, :scope => 'activerecord.models'),x]}
  end

  def rsvp_options(o)
    o.class.state_machines[:answer].states.map(&:name).map{|x|[t(x, :scope => 'activerecord.attributes.rsvp.answer'),x]}
  end

  def event_rsvp_numbers
    all = case @event.count_yes
      when 0 then t :rsvp_0
      when 1 then t :rsvp_1
      else        t :rsvp_n, :count => @event.count_yes
    end
    all = all[0].upcase + all[1..-1] + ". "
    if @rsvp && @rsvp.has_waitlist?
      all = all + t(:there_are_no_people_on_waitlist, :number => @rsvp.no_on_waitlist) + ". "
    end
    all
  end

  def event_rsvp_list_names
    @event.users_who_rsvped_yes.map{ |u| u.nickname }.join(", ")
  end

  def event_rsvp_type_explanation( rsvp_type )
    t(rsvp_type.to_s, :scope => 'activerecord.values.event.rsvp_type' )
  end

  def current_rsvp_status
    return t(:to_rsvp_please_login) + "." if @rsvp.nil?
    t(@rsvp.answer, :scope => 'rsvp_describe_answer_for_you') + "."
  end

  def horizontal_form_for(name, *args, &block)
    options = args.extract_options!
    extra_options = {:builder => HorizontalBootstrapFormBuilder, :html => { :class => 'form-horizontal' } }
    form_for(name, *(args << options.merge(extra_options)), &block)
  end

  def inline_form_for(name, *args, &block)
    options = args.extract_options!
    extra_options = {:builder => BootstrapFormBuilder, :html => { :class => 'form-inline' } }
    form_for(name, *(args << options.merge(extra_options)), &block)
  end

end

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

  # how to wrap most fields (text_field, email_field, ...)
  def wrap(attribute, options={}, result_of_super)
    help = options.delete(:help)
    help = @template.content_tag(:span, help, :class => 'help-inline') if help
    @template.content_tag(:div,
                          label(attribute, :class => 'control-label') +
                          @template.content_tag(:div, result_of_super + help, :class => "controls"),
                          :class => "control-group")
  end

  def password_field(attribute, options={})
    help = options.delete(:help)
    wrap(attribute, options, super)
  end
  def email_field(attribute, options={})
    help = options.delete(:help)
    wrap(attribute, options, super)
  end
  def text_field(attribute, options={})
    help = options.delete(:help)
    wrap(attribute, options, super)
  end
  def text_area(attribute, options={})
    help = options.delete(:help)
    wrap(attribute, options, super)
  end
  def select(attribute, o, options={})
    help = options.delete(:help)
    wrap(attribute, options, super)
  end


  def check_box(attribute, options={})
    help = options.delete(:help)
    help = @template.content_tag(:span, help, :class => 'help-inline') if help
    @template.content_tag(:div,
                          @template.content_tag(:div, super + label(attribute) + help, :class => "controls"),
                          :class => "control-group")
  end

  def submit(attribute, options={})
    options[:class] = 'btn btn-primary'
    super(attribute,options)
  end
end

class HorizontalBootstrapFormBuilder < BootstrapFormBuilder
  def submit(attribute, options={})
    @template.content_tag(:div, super(attribute,options), :class => "form-actions")
  end
end

