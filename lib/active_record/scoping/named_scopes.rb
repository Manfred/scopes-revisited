module ActiveRecord
  module Scoping
    module NamedScopes
      def scopes
        read_inheritable_attribute(:scopes) || write_inheritable_attribute(:scopes, {})
      end

      def named_scope(name, query_parameters)
        scopes[name] = query_parameters
        
        (class << self; self end).instance_eval do
          define_method name do
            ActiveRecord::Scoping::Scope.new(self, name)
          end
        end
      end
    end
  end
end