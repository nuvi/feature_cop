module FeatureCop
  module Whitelist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def whitelist_from_yaml(file = "feature_cop_whitelist.yml")
        if ::File.exists?(file)
          absolute_path = file       
        else
          absolute_path = ::File.expand_path(::File.join("config", file))
          raise "#{file} not found!" unless ::File.exists?(absolute_path)
        end

        self.whitelist = ::YAML.load_file(absolute_path)[env]      
      end

      def whitelist(identifier)
        return false if @whitelist.nil?
        @whitelist.include?(identifier)
      end

      def whitelist=(whitelist)
        @whitelist = whitelist
      end
    end
  end
end
