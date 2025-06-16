#!/usr/bin/env -S falcon host
# frozen_string_literal: true

require "falcon/environment/rack"

hostname = File.basename(__dir__)
port = ENV["PORT"] || 3000

service hostname do
  include Falcon::Environment::Rack

  # By default, Falcon uses Etc.nprocessors to set the count, which is likely incorrect on shared hosts like Heroku.
  # Review the following for guidance about how to find the right value for your app:
  # https://help.heroku.com/88G3XLA6/what-is-an-acceptable-amount-of-dyno-load
  # https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#workers
  count ENV.fetch("WEB_CONCURRENCY", 1).to_i

  # If using count > 1 you may want to preload your app to reduce memory usage and increase performance:
  preload "preload.rb"

  # Heroku only supports HTTP/1.1 at the time of this writing. Review the following for possible updates in the future:
  # https://devcenter.heroku.com/articles/http-routing#http-versions-supported
  # https://github.com/heroku/roadmap/issues/34
  endpoint Async::HTTP::Endpoint
             .parse("http://0.0.0.0:#{port}")
             .with(protocol: Async::HTTP::Protocol::HTTP11)
end
