require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    root_files = FileList["README.rdoc"]
    gem.name = "ruby-lastfm"
    gem.version = "0.0.2"
    gem.summary = "Ruby library for the Last.fm API."
    gem.email = "ysbaddaden@gmail.com"
    gem.homepage = "http://github.com/ysbaddaden/ruby-lastfm"
    gem.description = "Ruby library for the Last.fm API."
    gem.authors = ['Julien Portalier']
    gem.files = root_files + FileList["{lib}/*"]
    gem.extra_rdoc_files = root_files
    gem.add_dependency "nokogiri"
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end

