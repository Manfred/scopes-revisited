require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class ScopesTest < ActiveSupport::TestCase
  test "models should have a local scope stack" do
    assert_equal [], Book.send(:scope_stack)
  end
  
  test "with_scope should add to the locale scope stack" do
    Book.send(:with_scope, :find, :conditions => { :published => true }) do
      assert_equal [[:find, { :conditions => { :published => true }}]], Book.send(:scope_stack)
    end
  end
end