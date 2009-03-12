module ActiveRecord
  module Scoping
    module NamedScopes
      def named_scope(name, query_parameters)
        (class << self; self end).instance_eval do
          define_method name do
          end
        end
      end
    end
  end
end