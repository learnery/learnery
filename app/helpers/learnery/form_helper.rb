module Learnery
module FormHelper

  def inline_form_for(name, *args, &block)
    options = args.extract_options!
    extra_options = {:builder => BootstrapFormBuilder, :html => { :class => 'form-inline' } }
    form_for(name, *(args << options.merge(extra_options)), &block)
  end

  def horizontal_form_for(name, *args, &block)
    options = args.extract_options!
    extra_options = {:builder => HorizontalBootstrapFormBuilder, :html => { :class => 'form-horizontal' } }
    form_for(name, *(args << options.merge(extra_options)), &block)
  end

  # TODO: use this in the apps/themes
  field_error_proc  = Proc.new do |html_tag, object|
    html = Nokogiri::HTML::DocumentFragment.parse(html_tag)
    html = html.at_css("input") || html.at_css("textarea") || html.at_css("select")
    unless html.nil?
      css_class = html['class'] || ""
      html['class'] = css_class.split.push("error").join(' ')
      html_tag = html.to_s + "<span class='help-inline'>" + object.error_message.join(". ") + "</span>"
    end
    html_tag.html_safe
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

    def text_display(attribute, value)
      @template.content_tag(:div,
                            label(attribute, :class => 'control-label') +
                            @template.content_tag(:div, value, :class => "controls"),
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
    def text_display(attribute, value)
      @template.content_tag(:div,
                            label(attribute, :class => 'control-label') +
                            @template.content_tag(:div, value, :class => "controls"),
                            :class => "control-group")
    end
  end

end
end
