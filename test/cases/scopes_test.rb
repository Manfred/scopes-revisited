require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class ScopesTest < ActiveSupport::TestCase
  test "models should have a local scope stack" do
    assert_equal [], Book.send(:scope_stack)
  end

  test "with_scope should properly maintain the scope stack between nested scope blocks" do
    assert_equal [], Book.send(:scope_stack)
    Book.send(:with_scope, :find, :conditions => { :published => true }) do
      assert_equal [[:find, { :conditions => { :published => true }}]], Book.send(:scope_stack)
      Book.send(:with_scope, :find, :conditions => { :published => false }) do
        assert_equal [[:find, { :conditions => { :published => true }}], [:find, { :conditions => { :published => false }}]], Book.send(:scope_stack)
      end
      assert_equal [[:find, { :conditions => { :published => true }}]], Book.send(:scope_stack)
    end
    assert_equal [], Book.send(:scope_stack)
  end

  test "with_scope should restore the stack after the block is done, even when it raised an exception" do
    begin
      Book.send(:with_scope, :find, :conditions => { :published => true }) do
        raise RuntimeError
      end
    rescue RuntimeError
    end
    assert_equal [], Book.send(:scope_stack)
  end
end