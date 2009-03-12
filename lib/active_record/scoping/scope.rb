module ActiveRecord
  module Scoping
    class Scope
      def initialize(owner, name)
        @owner, @name = owner, name
      end
    end
  end
end