namespace :Build do

  task :default => :all

  desc "build all components"
  task :all => [:install_bower_deps]

  desc "install bower components"
  task :install_bower_deps do
    sh "bower prune"
    sh "bower install"
    sh "rm -rf public/vendor"
    sh "mkdir -p public/vendor"
    sh "cp -r bower_components/* public/vendor"
  end
end