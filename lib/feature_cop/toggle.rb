module FeatureCop
  module Toggle

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def enabled(*args)
        true
      end

      def disabled(*args)
        false
      end
    end
  end
end
