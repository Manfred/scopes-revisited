require 'active_record/scoping/scope'
require 'active_record/scoping/scopes'
require 'active_record/scoping/named_scopes'

module ActiveRecord
  module Scoping
    METHOD_TO_ACTION = Hash.new(:find).merge({
      :new   => :create,
      :build => :create
    })
  end

  class Base
    include ActiveRecord::Scoping::Scopes
    extend ActiveRecord::Scoping::NamedScopes
  end
end