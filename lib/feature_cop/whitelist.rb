module FeatureCop
  module Whitelist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
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
