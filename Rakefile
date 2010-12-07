require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    root_files = FileList["README.rdoc"]
    s.name = "ruby-lastfm"
    s.version = "0.0.1"
    s.summary = "Ruby library for the Last.fm API."
    s.email = "ysbaddaden@gmail.com"
    s.homepage = "http://github.com/ysbaddaden/ruby-lastfm"
    s.description = "Ruby library for the Last.fm API."
    s.authors = ['Julien Portalier']
    s.files =  root_files + FileList["{lib}/*"]
    s.extra_rdoc_files = root_files
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end

