ENV['RAILS_ENV'] = 'test'

require 'test/unit'

require 'rubygems'
require 'active_support'
require 'active_support/test_case'

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'active_record'

$:.unshift(File.expand_path('../', __FILE__))

class << ActiveRecord::Base
  public :with_scope, :scope_stack

  def scope_stack=(stack)
    Thread.current[:scope_stacks][name] = stack
  end
end