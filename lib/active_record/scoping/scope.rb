module ActiveRecord
  module Scoping
    class Scope
      def initialize(owner, name, query_parameters)
        @owner, @name, @query_parameters = owner, name, query_parameters
      end
    end
  end
end