namespace :theme do
  desc "install blank theme WITHOUT submodule (no internet connection needed)"
  task :blank do
    `rails generate theme`
  end

  desc "install theme as git submodule, e.g. rake theme:install blank or rake theme:install https://github.com/MYGIHUB/my-private-theme.git"
  task :install do
    git_url = ARGV[1].strip

    # default themes
    git_url = case git_url
      when "blank"      then "https://github.com/learnery/theme-blank.git"
      when "webdev"     then "https://github.com/learnery/theme-webdev.git"
      when "coderdojo"  then "https://github.com/learnery/theme-coderdojo.git"
      when "railsgirls" then "https://github.com/learnery/theme-railsgirls.git"
      else git_url
    end

    # checking validity of git-url
    if git_url =~ /^(git|https?):\/\/github.com/
      url_parts = git_url.scan(/\/([^\/]+)/).flatten
      if url_parts.length > 1 then
        github_username = url_parts[1]
        theme_name = url_parts[2].sub(/\.git/,'')
      end
    end
   
    if [github_username, theme_name].any?(&:nil?)
      puts "#{git_url} is not a valid address on github."
      exit(0)
    end
    

    origin      = git_url
    destination = "theme"
    submodule_name = next_submodule_name


    if open('.gitmodules').grep(/submodule "theme"/).any? || open('.git/config').grep(/submodule "theme"/).any? then
      puts "Theme is already installed as a submodule. run 'rake theme:remove' first."
      exit(0)
    end

    if File.directory?(destination) 
      puts "Theme is already installed. run 'rake theme:remove' first."
      exit(0)
    end

    puts "git submodule add --name #{submodule_name} #{origin} #{destination}"
    exit(0)
  end
  
  desc "remove theme (submodule'd or not)"
  task :remove do
    
    newtext = File.read(".gitmodules").sub(/\[submodule "theme"\]\n\s*path = theme\n\s*url = .*\n/,'')
    File.open(".gitmodules", "w") do |gitmodule|
      gitmodule.write(newtext)
    end
    puts "Removed declaration from .gitmodules."

    newtext = File.read(".git/config").sub(/\[submodule "theme"\]\n\s*url = .*\n/,'')
    File.open(".git/config", "w") do |gitmodule|
      gitmodule.write(newtext)
    end
    puts "Removed declaration from .git/config"

    system "git rm --cached theme --ignore-unmatch"
    rm_r "theme" if File.directory? "theme" 
    puts "Removed folder from file system and git cache"

    puts "Done!"
    exit(0)
  end
  
  desc "update a theme"
  task :update => "git:submodules:init" do
    puts "not implemented"
    exit(0)
    plugin_name = ARGV[1].strip
    (puts "Plugin #{plugin_name} not found."; exit(0)) unless plugin_installed?(plugin_name)

    submodule = plugins_list.find{|p| p[:name] == plugin_name}
    puts "Updating #{submodule[:name]}..."
    system "cd #{submodule[:path]} && git checkout master && git pull && cd ../.."
    puts "Done!"
    exit(0)
  end

  desc "Display info about theme"
  task :show do
    pp theme_info
  end
end

namespace :git do
  def theme_info
    gitmodules_file = read_theme_from_gitmodules_or_fail
    lines = gitmodules_file.split("\n")
    submodules = []
    lines.each_slice(3) do |declaration|
      next if declaration[1] =~ /theme/
      path = declaration[1].split('=')[1].strip
      
      if (head = File.read("#{path}/.git/HEAD")).include?(':')
        hash = File.read(path + "/.git/" + head.split(':')[1].strip).strip
      else
        hash = head
      end
      
      theme = {
        :path => path,
        :name => path.split('/').last,
        :url => declaration[2].split('=')[1].strip,
        :hash => hash
      }
    end
    
    theme
  end

  def next_submodule_name
    return "theme-0" if !File.directory? '.git/modules'

    next_no = Dir.glob('.git/modules/theme*').map{|s| s.match(/\d*$/)[0].to_i}.max + 1

    "theme-#{next_no}"
  end

  def read_theme_from_gitmodules_or_fail
    if !File.exist?('.gitmodules') || 
      (gitmodules_file = File.read('.gitmodules').strip).empty? ||
      (gitmodules_file.split("\n").size < 6 && gitmodules_file =~ /theme/)
      puts "No theme found."
      exit(0)
    end
    gitmodules_file
  end

  def theme_installed?
    File.directory?('theme') && File.exists?('theme/initializer.rb')
  end
end
