module Learnery
module TwitterBootstrapExtensionsHelper

  # including this here is a nasty workaround to
  # get the engine version running
  # copied from https://github.com/seyhunak/twitter-bootstrap-rails/blob/master/app/helpers/bootstrap_flash_helper.rb
#  def bootstrap_flash
#    flash_messages = []
#    flash.each do |type, message|
#      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
#      next if message.blank?
#
#      type = :success if type == :notice
#      type = :error   if type == :alert
#      next unless ALERT_TYPES.include?(type)
#
#      Array(message).each do |msg|
#        text = content_tag(:div,
#                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
#                           msg.html_safe, :class => "alert fade in alert-#{type}")
#        flash_messages << text if msg
#      end
#    end
#    flash_messages.join("\n").html_safe
#  end
#


end
end
