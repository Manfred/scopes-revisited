require 'active_record/scoping/scopes'

module ActiveRecord
  class Base
    extend ActiveRecord::Scoping::Scopes
  end
end