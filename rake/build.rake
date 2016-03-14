namespace :Build do

  task :default => :all

  desc "build all components"
  task :all => [:install_bower_deps]

  desc "install bower components"
  task :install_bower_deps do
    sh "bower prune"
    sh "bower install"
    sh "rm -rf lib/public/vendor"
    sh "mkdir -p lib/public/vendor"
    sh "cp -r bower_components/* lib/public/vendor"
  end
end