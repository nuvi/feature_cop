module FeatureCop
  module Blacklist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def blacklist_from_yaml(file = "feature_cop_blacklist.yml")
        if ::File.exists?(file)
          absolute_path = file       
        else
          absolute_path = ::File.expand_path(::File.join("config", file))
          raise "#{file} not found!" unless ::File.exists?(absolute_path)
        end

        self.blacklist = ::YAML.load_file(absolute_path)[env]      
      end

      def all_except_blacklist(identifier)
        return true if @blacklist.nil?
        !@blacklist.include?(identifier)
      end


      def blacklist
        @blacklist 
      end

      def blacklist=(blacklist)
        @blacklist = blacklist
      end

    end
  end
end
