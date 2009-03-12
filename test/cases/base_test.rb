require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class BaseTest < ActiveSupport::TestCase
  def setup
    Book.scope_stack = []
  end

  test "should properly merge empty scope stacks" do
    Book.scope_stack = []
    assert_equal({}, Book.merge_scope(:find))
    assert_equal({}, Book.merge_scope(:create))
  end

  test "should properly merge simple scope stacks" do
    Book.scope_stack = [[:find, { :conditions => { :published => true } }]]
    assert_equal({ :conditions => { :published => true } }, Book.merge_scope(:find))
    assert_equal({}, Book.merge_scope(:create))
  end

  test "should merge existing keys in the scope stack" do
    Book.scope_stack = [[:find, { :conditions => { :published => true } }], [:find => { :conditions => { :published => false } }]]
    assert_equal({ :conditions => { :published => true } }, Book.merge_scope(:find))
    assert_equal({}, Book.merge_scope(:create))
  end

  test "should merge extra keys in the scope stack" do
    Book.scope_stack = [[:find, { :conditions => { :isbn => '978-0345508935' } }], [:find, { :conditions => { :published => false } }]]
    assert_equal({ :conditions => { :isbn => '978-0345508935', :published => false } }, Book.merge_scope(:find))
    assert_equal({}, Book.merge_scope(:create))
  end

  test "should build query parameters for a unscoped find" do
    Book.expects(:construct_finder_sql).with({:select => :all, :table_name => 'books'})
    Book.find(:all)
  end

  test "should build query parameters for a scoped find" do
    Book.expects(:construct_finder_sql).with({:select => :all, :table_name => 'books', :conditions => { :published => true }})

    Book.with_scope(:find, :conditions => { :published => true }) do
      Book.find(:all)
    end 
  end

  def teardown
    Book.scope_stack = []
  end
end