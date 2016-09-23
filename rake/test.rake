require 'rake/testtask'
namespace :Test do

  ENV["RACK_ENV"] = "test"

  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['./**/*_spec.rb', './**/*_test.rb']
    t.verbose = true
  end

  task :all => [:environment, :test]
end