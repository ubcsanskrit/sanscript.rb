# frozen_string_literal: true
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "thermite/tasks"

RSpec::Core::RakeTask.new(:spec)
Thermite::Tasks.new

task default: :spec
