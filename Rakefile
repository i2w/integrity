require "rake/testtask"
require "rake/clean"

desc "Default: run all tests"
task :default => :test

desc "Run tests"
task :test => %w[test:unit test:acceptance]
namespace :test do
  desc "Run unit tests"
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList["test/unit/*_test.rb"]
  end

  desc "Run acceptance tests"
  Rake::TestTask.new(:acceptance) do |t|
    t.libs << "test"
    t.test_files = FileList["test/acceptance/*_test.rb"]
  end
end

task :db do
  require "init"
  DataMapper.auto_upgrade!
end

desc "Clean-up build directory"
task :cleanup do
  require "init"
  Integrity::Build.all(:completed_at.not => nil).each { |build|
    dir = Integrity.directory.join(build.id.to_s)
    dir.rmtree if dir.directory?
  }
end

namespace :jobs do
  desc "Clear the delayed_job queue."
  task :clear do
    require "init"
    require "integrity/builder/delayed"
    Delayed::Job.delete_all
  end

  desc "Start a delayed_job worker."
  task :work do
    require "init"
    require "integrity/builder/delayed"
    Delayed::Worker.new.start
  end
end

begin
  namespace :resque do
    require "resque/tasks"

    desc "Start a Resque worker for Integrity"
    task :work do
      require "init"
      ENV["QUEUE"] = "integrity"
      Rake::Task["resque:resque:work"].invoke
    end
  end
rescue LoadError
end

desc "Generate HTML documentation."
file "doc/integrity.html" => ["doc/htmlize",
  "doc/integrity.txt",
  "doc/integrity.css"] do |f|
  sh "cat doc/integrity.txt | doc/htmlize > #{f.name}"
end

CLOBBER.include("doc/integrity.html")

desc "Remove the current builds from the filesystem, and all but the last 7 days of builds"
task :clean_builds do
  `rm -rf builds/*`
  require 'init'
  Integrity::Build.all(:updated_at.lt => Time.now - (7 * 24 * 60 * 60)).each {|r| r.destroy!}
end

desc "Build all public projects"
task :build_public_projects do
  require 'init'
  Integrity::Project.all(:public => true).each do |p|
    p.build('HEAD')
  end
end

desc "Update the crontab with the schedule"
task :schedule do
  sh "whenever -f schedule.rb --update-crontab integrity"
end