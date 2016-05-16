module FeatureCop
  module Sampling

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def sample10(feature, identifier, options = {})
        return true if whitelisted?(feature, identifier, options)
        return false if blacklisted?(feature, identifier, options)
        identifier.bytes.sum % 10 == 0 
      end

      def sample30(feature, identifier, options = {})
        return true if whitelisted?(feature, identifier, options)
        return false if blacklisted?(feature, identifier, options)
        identifier.bytes.sum % 3 == 0 
      end

      def sample50(feature, identifier, options = {})
        return true if whitelisted?(feature, identifier, options)
        return false if blacklisted?(feature, identifier, options)
        identifier.bytes.sum.odd? 
      end
    end
  end
end
