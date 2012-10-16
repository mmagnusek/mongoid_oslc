require 'mongoid/oslc/strategy'

# OSLC
OSLC_FIELDS_MAPPING ||= {
  "dcterms:title"           => "title",
  "dcterms:description"     => "description",
  "dcterms:created"         => "created_at",
  "oslc_cm:closed"          => "closed"
}

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
