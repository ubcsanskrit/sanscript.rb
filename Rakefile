# frozen_string_literal: true

require "bundler/gem_tasks"

require "thermite/tasks"
Thermite::Tasks.new(optional_rust_extension: true)
task default: :"thermite:build"

# Ensure missing RSpec development dependency doesn't kill gem install.
begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  nil
end

# Ensure missing Rubocop development dependency doesn't kill gem install.
begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  nil
end
