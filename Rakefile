# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "rubocop/rake_task"

Rake.add_rakelib("lib/tasks")

Rake::TestTask.new(:test) do |t|
  t.libs = ["lib", "test"]
  t.test_files = FileList["test/**/test_*.rb"]
end

RuboCop::RakeTask.new(:lint) do |t|
  t.options = ["--display-cop-names"]
end

desc "Run tests"
task default: :test
