
module ApplicationHelper
  include Learnery::FormHelper
  include Learnery::AuthenticationHelper
  include Learnery::RsvpHelper

  def model_errors(model)
    flash_messages = []
    if model.errors.none?
      return ""
    else
      t_model = t(model.class.model_name.i18n_key, :scope => 'activerecord.models')
      header = t('errors.template.header',  :count => model.errors.count, :model => t_model)
      flash_messages << header
      model.errors.full_messages.each do |message|
        flash_messages << "#{message}."
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

  def class_to_filename(klass)
    klass.to_s.split('::').last.underscore
  end

  def event_type_options
    Learnery::Event.implementations.map(&:to_s).map{|x|[t(x.ucfirst, :scope => 'activerecord.models'),x]}
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
  def date_field(attribute, options={})
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


class String
  def ucfirst
    result = self
    result[0] = result[0].upcase 
    result
  end
end
