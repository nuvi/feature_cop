require "rubygems"
require "active_support/inflector"
require "active_support/inflections"
require "feature_cop/version"
require "feature_cop/enumerable_extensions"
require "feature_cop/whitelist"
require "feature_cop/blacklist"
require "feature_cop/sampling"
require "feature_cop/toggle"
require "json"
require "yaml"

require "generators/migrations"
require "feature_cop/models/user_list"

module FeatureCop
  include FeatureCop::Whitelist
  include FeatureCop::Blacklist
  include FeatureCop::Sampling
  include FeatureCop::Toggle

  class << self
    def allows?(feature, identifier = nil, options = {})
      feature_status = ENV["#{feature.to_s.upcase}"]
      return false if feature_status.nil? 
      self.method(feature_status.downcase).call(feature.to_s, identifier.to_s, options)
    end

    def env
      @env ||= ENV["RAILS_ENV"] || ENV["RACK_ENV"] || ENV["APP_ENV"] || ENV["APP_ENV"] || "development"
    end

    def features
      @features ||= self.set_features
    end

    def reset_features
      @features = self.set_features
    end

    def set_features
      features = {}
      ENV.each_pair do |key, value|
        features[key] = value if key.end_with?("_FEATURE")
      end
      return features
    end

    def as_json(identifier = nil)
      feature_set = {}
      features.each_pair do |feature, setting|
        feature_set[feature.downcase.camelize(:lower)] = self.method(setting.downcase).call(feature, identifier)
      end
      feature_set
    end

    def to_json(identifier = nil)
      self.as_json(identifier).to_json
    end

    def load_database
      black = Blacklist.from_yaml
      white = Whitelist.from_yaml

      byebug
      UserList.create(black)
      Userlist.create(white)
    end
  end
end

