require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class NamedScopeTest < ActiveSupport::TestCase
  test "named scope methods should initialize a new scope instance" do
    assert Book.published.kind_of?(ActiveRecord::Scoping::Scope)
  end

  test "a Scope should delegate scopes to the scope owner" do
    owner = stub
    owner.expects(:scopes)
    scope = ActiveRecord::Scoping::Scope.new(owner, :published)
    scope.scopes
  end

  test "named scopes should be stored on the class for later retrieval" do
    assert Book.scopes.has_key?(:published)
    assert_equal({:conditions => { :published => true }}, Book.scopes[:published])
    assert Book.scopes.has_key?(:draft)
    assert_equal({:conditions => { :published => false }}, Book.scopes[:draft])
  end
end