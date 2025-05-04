# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'rack/rewrite'

use Rack::Rewrite do
  # Redirect all requests from tcg-place.com to www.tcg-place.com
  r301(/.*/, 'https://www.tcg-place.com$&', if: proc { |rack_env|
    rack_env['HTTP_HOST'] == 'tcg-place.com'
  })
end

run Rails.application
