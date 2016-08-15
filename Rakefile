# frozen_string_literal: true
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :compile do
  Dir.chdir("#{File.dirname(__FILE__)}/rust")
  require "./extconf.rb"
  sh "cargo build --release && cp target/release/libsanscript.* ." if File.exist?("Makefile")
end
