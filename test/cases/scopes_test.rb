require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class ScopesTest < ActiveSupport::TestCase
  test "models should have a local scope stack" do
    assert_equal [], Book.scope_stack
  end

  test "with_scope should properly maintain the scope stack between nested scope blocks" do
    published_scope = [:find, {:conditions => { :published => true }}]
    draft_scope     = [:find, {:conditions => { :published => false }}]
    
    assert_equal [], Book.scope_stack
    Book.with_scope(*published_scope) do
      assert_equal [published_scope], Book.scope_stack
      Book.with_scope(*draft_scope) do
        assert_equal [published_scope, draft_scope], Book.scope_stack
      end
      assert_equal [published_scope], Book.scope_stack
    end
    assert_equal [], Book.scope_stack
  end

  test "with_scope should restore the stack after the block is done, even when it raised an exception" do
    begin
      Book.with_scope(:find, {}) do
        raise RuntimeError
      end
    rescue RuntimeError
    end
    assert_equal [], Book.scope_stack
  end
end