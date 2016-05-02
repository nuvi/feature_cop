module FeatureCop
  module Whitelist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def whitelist_from_yaml(file = "feature_cop_whitelist.yml")
        if ::File.exist?(file)
          absolute_path = file
        elsif defined?(Rails)
          absolute_path = ::File.join(Rails.root, "config", file)
        end

        raise "#{file} not found!" unless ::File.exist?(absolute_path)
        self.whitelist = ::YAML.load_file(absolute_path)[env]
      end

      def whitelist
        @whitelist
      end

      def whitelist=(whitelist)
        @whitelist = whitelist
      end

      def whitelist_only(identifier)
        whitelisted?(identifier)
      end

      def whitelisted?(identifier)
        return false if @whitelist.nil?
        @whitelist.include?(identifier)
      end
    end
  end
end
