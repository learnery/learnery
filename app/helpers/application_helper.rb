module ApplicationHelper

  def rsvp_options
    Rsvp::ANSWERS.map{|x|[t(x, :scope => 'activerecord.attributes.rsvp.answer'),x]}
  end

  def event_rsvp_numbers
    case @event.count_yes
      when 0 then t :rsvp_0
      when 1 then t :rsvp_1
      else        t :rsvp_n, :count => @event.count_yes
    end
  end

  def event_rsvp_list_names
    @event.users_who_rsvped_yes.map{ |u| u.nickname }.join(", ")
  end

  def current_rsvp_status
    if @rsvp and @rsvp.id then "You said #{@rsvp.answer}." end
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
