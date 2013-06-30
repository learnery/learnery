module Learnery
  class ThemeGenerator < Rails::Generators::Base
    @@app_root = '../../../../'

    source_root File.expand_path("#{@@app_root}test/dummy/app", __FILE__)

    desc "This generator creates a default theme for learnery"

    def hello_world
      puts "++++ learnery.theme generator"
    end

    def copy_files
      # these are thor actions, see
      # http://rdoc.info/github/wycats/thor/master/Thor/Actions.html
      copy_file "assets/stylesheets/variables.css.less",
      "app/assets/stylesheets/variables.css.less"
      copy_file "assets/stylesheets/style.css.less",
       "app/assets/stylesheets/style.css.less"

      destination_root = File.join(@@app_root,"app/views/learnery")
      directory "views/learnery", "app/views/learnery"
    end
    def remove_files
      remove_file 'app/assets/javascripts/application.js'
      remove_file 'app/helpers/application_helper.rb'
    end
  end
  private

end
