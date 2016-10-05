require "active_support/core_ext"

module FeatureCop
  class UserList < ActiveRecord::Base
    self.table_name = :user_list # was defaulting to user_lists

    enum list: [:disabled, :whitelist, :blacklist]

    scope :disabled,  -> { where( list: 0) }
    scope :whitelist, -> { where( list: 1) }
    scope :blacklist, -> { where( list: 2) }

    class << self
      alias_method :white, :whitelist
      alias_method :black, :blacklist
      
      def blacklist_ids
        black.pluck(:identifier)
      end

      def whitelist_ids
        white.pluck(:identifier)
      end
    end

    def blacklist!
      update!(:list => :blacklist)
    end

    def whitelist!
      update!(:list => :whitelist)
    end

    def disable!
      update!(:list => :disabled)
    end
  end
end