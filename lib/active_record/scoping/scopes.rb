require 'thread'

module ActiveRecord
  module Scoping
    module Scopes
      def self.extended(base)
        Thread.current[:scope_stacks] ||= {}
      end

      protected
        def with_scope(method, query_parameters, &block)
          self.scope_stack << [method, query_parameters]
          begin
            block.call
          ensure
            self.scope_stack.pop
          end
        end

        def scope_stack
          Thread.current[:scope_stacks][name] ||= []
        end
    end
  end
end