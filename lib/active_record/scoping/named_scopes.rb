module ActiveRecord
  module Scoping
    module NamedScopes
      def named_scope(name, query_parameters)
        (class << self; self end).instance_eval do
          define_method name do
            ActiveRecord::Scoping::Scope.new(self, name, query_parameters)
          end
        end
      end
    end
  end
end