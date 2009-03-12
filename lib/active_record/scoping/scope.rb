module ActiveRecord
  module Scoping
    class Scope
      attr_accessor :owner
      delegate :scopes, :to => :owner

      def initialize(owner, name)
        @owner, @name = owner, name
      end

      def method_missing(method, *arguments, &block)
        if scopes[method]
          ActiveRecord::Scoping::Scope.new(self, method)
        else
          owner.send(method, *arguments, &block)
        end
      end
    end
  end
end