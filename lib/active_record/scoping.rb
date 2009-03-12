require 'active_record/scoping/scope'
require 'active_record/scoping/scopes'
require 'active_record/scoping/named_scopes'

module ActiveRecord
  class Base
    extend ActiveRecord::Scoping::Scopes
    extend ActiveRecord::Scoping::NamedScopes
  end
end