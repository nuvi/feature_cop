module FeatureCop
  module Blacklist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def blacklist_from_yaml(file = "feature_cop_blacklist.yml")
        if ::File.exist?(file)
          absolute_path = file
        elsif defined?(Rails)
          absolute_path = ::File.join(Rails.root, "config", file)
        end

        raise "#{file} not found!" unless ::File.exist?(absolute_path)
        self.blacklist = ::YAML.load_file(absolute_path)[env]
      end

      def all_except_blacklist(feature, identifier, options = {})
        return true if blacklist.nil?
        !blacklisted?(feature, identifier, options)
      end

      def blacklist
        @blacklist ||= {} 
      end

      def blacklist=(blacklist)
        if blacklist.is_a?(Array)
          @blacklist = { "default" => blacklist }
          return
        end
        @blacklist = blacklist
      end

      def blacklisted?(feature, identifier, options = {})
        feature = "default" if blacklist[feature].nil?
        return false if blacklist[feature].nil?
        blacklist[feature].include?(identifier)
      end
    end
  end
end
