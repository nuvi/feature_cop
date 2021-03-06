require "rubygems"
require "active_support/hash_with_indifferent_access"
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



module FeatureCop
  include FeatureCop::Whitelist
  include FeatureCop::Blacklist
  include FeatureCop::Sampling
  include FeatureCop::Toggle

  def self.allows?(feature, identifier = nil, options = {})
    feature_setting = self.features[feature]
    return false if feature_setting.nil?
    self.method(feature_setting).call(feature.to_s, identifier.to_s, options)
  end

  def self.env
    @env ||= ENV["RAILS_ENV"] || ENV["RACK_ENV"] || ENV["APP_ENV"] || "development"
  end

  def self.features
    @features ||= self.set_features
  end

  def self.reset_features
    @features = self.set_features
  end

  def self.set_features
    features = ::ActiveSupport::HashWithIndifferentAccess.new
    ENV.each_pair do |key, value|
      features[key.downcase] = value.downcase if key.end_with?("_FEATURE")
    end
    return features
  end

  def self.as_json(identifier = nil)
    feature_set = {}
    features.each_pair do |feature, setting|
      feature_set[feature.downcase.camelize(:lower)] = self.method(setting.downcase).call(feature, identifier)
    end
    feature_set
  end

  def self.to_json(identifier = nil)
    self.as_json(identifier).to_json
  end
end

