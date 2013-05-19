class ThemeGenerator < Rails::Generators::Base
  source_root File.expand_path("../theme/templates", __FILE__)
  desc "This generator creates an empty theme for learnary"

  def copy_files
    copy_file "initializer.rb",                         "theme/initializer.rb"
    copy_file "stylesheets/variables.css.less",         "theme/stylesheets/variables.css.less"
    copy_file "stylesheets/style.css.less",             "theme/stylesheets/style.css.less"
    copy_file "views/application/_site_links.html.erb", "theme/views/application/_site_links.html.erb"
    copy_file "views/application/_footer.html.erb",     "theme/views/application/_footer.html.erb"
  end
end
