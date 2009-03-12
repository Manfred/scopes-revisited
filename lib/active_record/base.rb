module ActiveRecord
  class Base
    def self.find(action, options={})
      options = merge_scope(:find, options)
      options[:table_name] ||= name.to_s.tableize
      
      case action
      when :all
        options[:select] = :all
      end

      find_by_sql(construct_finder_sql(options))
    end

    def self.merge_scope(method, options={})
      merged = {}
      scope_stack.each do |scope_method, scope_options|
        merged.deep_merge!(scope_options) if method == scope_method
      end
      merged
    end

    def self.construct_finder_sql(options)
    end

    def self.find_by_sql(sql)
    end
  end
end