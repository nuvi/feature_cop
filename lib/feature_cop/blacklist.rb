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
        return true if @blacklist.nil?
        !blacklisted?(feature, identifier, options)
      end

      def blacklist
        @blacklist 
      end

      def blacklist=(blacklist)
        @blacklist = blacklist
      end

      def blacklisted?(feature, identifier, options = {})
        return false if blacklist.nil?
        blacklist.include?(identifier)
      end
    end
  end
end
