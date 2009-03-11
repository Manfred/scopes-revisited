require 'active_record/scoping/scopes'

module ActiveRecord
  class Base
    include ActiveRecord::Scoping::Scopes
  end
end