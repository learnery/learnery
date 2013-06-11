module TwitterBootstrapExtensionsHelper
  def model_errors(model)
    flash_messages = []
    if model.errors.none?
      return ""
    else
      header = "There was #{pluralize(model.errors.count, "problem")} saving this #{model.class}:"
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
end
