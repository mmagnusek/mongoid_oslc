require 'mongoid'
require 'mongoid/oslc/version'
require 'mongoid/oslc/strategy'
require 'active_support/concern'

module Mongoid
  module Oslc
    extend ActiveSupport::Concern

    module ClassMethods
      def oslc_where(query)
        mongoid_query = Strategy.to_query(query)
        where(mongoid_query)
      end
    end
  end
end
