#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)
require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["jinhua", 'jinhua']
end
run Rack::URLMap.new(
  "/admin/sidekiq" => Sidekiq::Web,
  "/" => Padrino.application)
#run Padrino.application
