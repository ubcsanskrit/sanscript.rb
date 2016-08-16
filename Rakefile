# frozen_string_literal: true
require "bundler/gem_tasks"

# Add enhanced optional_build task into Thermite
require "thermite/tasks"
module Thermite
  class BetterTasks < Tasks
    def initialize(options = {})
      super
      desc "Run thermite:build task or download binaries, but skip without fail if unavailable."
      task "thermite:optional_build" do
        if cargo
          Rake::Task["thermite:build"].invoke
        elsif !download_binary
          puts "Rust and downloadable binaries are not available, skipping."
        end
      end
    end
  end
end
Thermite::BetterTasks.new
task default: :"thermite:optional_build"

# Ensure missing RSpec development dependency doesn't kill gem install.
begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  nil
end
