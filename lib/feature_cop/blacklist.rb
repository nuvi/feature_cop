module FeatureCop
  module Blacklist

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def blacklist(identifier)
        return true if @blacklist.nil?
        !@blacklist.include?(identifier)
      end

      def blacklist=(blacklist)
        @blacklist = blacklist
      end
    end
  end
end
