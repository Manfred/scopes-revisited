module ActiveRecord
  module Scoping
    class Scope
      attr_accessor :owner, :name
      delegate :scopes, :scope_stack, :to => :owner

      def initialize(owner, name)
        @owner, @name = owner, name
      end

      def method_missing(method, *arguments, &block)
        if scopes[method]
          ActiveRecord::Scoping::Scope.new(self, method)
        else
          scope_stack.unshift [METHOD_TO_ACTION[method], scopes[name]]
          begin
            owner.send(method, *arguments, &block)
          ensure
            scope_stack.shift
          end
        end
      end
    end
  end
end