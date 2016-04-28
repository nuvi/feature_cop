require "feature_board/version"
require "feature_board/enumerable_extensions"
require "json"

module FeatureBoard

  def self.features
    @features ||= self.get_features
  end

  def self.reset_features
    @features = self.get_features
  end

  def self.get_features
    features = {}
    ENV.each_pair do |key, value|
      features[key] = value if key.end_with?("_FEATURE")
    end
    return features
  end

  def self.method_missing(m, *args, &block)
    feature_name = m.to_s
    filters = ["?", "show_", "_feature"]
    filters.each { |filter| feature_name.gsub!(filter, "") }
    feature_status = ENV["#{feature_name.upcase}_FEATURE"]
    return false if feature_status.nil? 
    self.method(feature_status.downcase).call(args.first)
  end

  def self.enabled(indentifier)
    true
  end

  def self.whitelist(indentifier)
    true
  end

  def self.sample10(identifier)
    identifier.bytes.sum % 10 == 0 
  end

  def self.sample25(identifier)
    identifier.bytes.sum % 4 == 0 
  end

  def self.sample50(identifier)
    identifier.bytes.sum % 2 == 0 
  end
  
  def self.to_json(identifier)
    feature_set = {}
    features.each_pair do |key, value|
      feature_set[key] = self.method(value.downcase).call(identifier)  
    end
    feature_set.to_json
  end
end

