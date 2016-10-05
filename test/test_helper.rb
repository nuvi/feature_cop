$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "rails"
require "rails/generators"
require "rails/generators/active_record"

require 'feature_cop'
require 'securerandom'

require 'minitest/autorun'
require 'byebug'