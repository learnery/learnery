
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


class String
  def ucfirst
    result = self
    result[0] = result[0].upcase 
    result
  end
end
