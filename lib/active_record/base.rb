module ActiveRecord
  class Base
    attr_accessor :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def self.find(action, query_parameters={})
      query_parameters = merge_scope(:find, query_parameters)
      query_parameters[:table_name] ||= name.to_s.tableize

      case action
      when :all
        query_parameters[:select] = :all
      end

      find_by_sql(construct_finder_sql(query_parameters))
    end

    def self.merge_scope(method, query_parameters={})
      merged = {}
      scope_stack.each do |scope_method, scope_query_parameters|
        merged.deep_merge!(scope_query_parameters) if [:all, method].include?(scope_method)
      end
      merged
    end

    def self.construct_finder_sql(query_parameters)
    end

    def self.find_by_sql(sql)
    end
  end
end