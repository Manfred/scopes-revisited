require 'thread'

module ActiveRecord
  module Scoping
    module Scopes
      def self.included(base)
        Thread.current[:scope_stacks] = {}
        base.extend(ClassMethods)
      end

      module ClassMethods
        protected
          def with_scope(method, scope_options, &block)
            self.scope_stack << [method, scope_options]
            begin
              block.call
            ensure
              self.scope_stack.pop
            end
          end

          def scope_stack
            scope_stacks = Thread.current[:scope_stacks]
            scope_stacks[name] ||= []
          end
      end
    end
  end
end