require "rubygems"
require "active_support/inflector"
require "active_support/inflections"
require "feature_cop/version"
require "feature_cop/enumerable_extensions"
require "feature_cop/whitelist"
require "feature_cop/blacklist"
require "json"
require "yaml"



module FeatureCop
  include FeatureCop::Whitelist
  include FeatureCop::Blacklist

  def self.allows?(feature, identifier = nil, opts = {})
    feature_status = ENV["#{feature.to_s.upcase}"]
    return false if feature_status.nil? 
    self.method(feature_status.downcase).call(identifier)
  end

  def self.enabled(identifier)
    true
  end

  def self.disabled(identifier)
    false
  end

  def self.env
    @env ||= ENV["RAILS_ENV"] || ENV["RACK_ENV"] || ENV["APP_ENV"] || ENV["APP_ENV"] || "development"
  end

  def self.features
    @features ||= self.set_features
  end

  def self.reset_features
    @features = self.set_features
  end

  def self.sample10(identifier)
    return true if whitelisted?(identifier)
    return false if blacklisted?(identifier)
    identifier.bytes.sum % 10 == 0 
  end

  def self.sample30(identifier)
    return true if whitelisted?(identifier)
    return false if blacklisted?(identifier)
    identifier.bytes.sum % 3 == 0 
  end

  def self.sample50(identifier)
    return true if whitelisted?(identifier)
    return false if blacklisted?(identifier)
    identifier.bytes.sum.odd? 
  end

  def self.set_features
    features = {}
    ENV.each_pair do |key, value|
      features[key] = value if key.end_with?("_FEATURE")
    end
    return features
  end

  def self.as_json(identifier = nil)
    feature_set = {}
    features.each_pair do |key, value|
      feature_set[key.downcase.camelize(:lower)] = self.method(value.downcase).call(identifier)
    end
    feature_set
  end

  def self.to_json(identifier = nil)
    self.as_json(identifier).to_json
  end
end

