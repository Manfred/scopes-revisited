require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class NamedScopeTest < ActiveSupport::TestCase
  test "named scopes should intialize a new scope instance" do
    assert Book.published.kind_of?(ActiveRecord::Scoping::Scope)
  end

  test "named scopes should be stored on the class for later retrieval" do
    assert Book.scopes.has_key?(:published)
    assert_equal({:conditions => { :published => true }}, Book.scopes[:published])
    assert Book.scopes.has_key?(:draft)
    assert_equal({:conditions => { :published => false }}, Book.scopes[:draft])
  end
end