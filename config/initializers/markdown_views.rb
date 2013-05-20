module ActionView
  module Template::Handlers
    class Markdown
      class_attribute :default_format
      self.default_format = Mime::HTML

      def call(template)
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
        markdown.render(template.source).html_safe.inspect
      end

    end
  end
end

ActionView::Template.register_template_handler(:md, ActionView::Template::Handlers::Markdown.new)
