require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class ScopeTest < ActiveSupport::TestCase
  test "named scope methods should initialize a new scope instance when invoked on a Scope" do
    assert Book.published.draft.kind_of?(ActiveRecord::Scoping::Scope)
  end
  
  test "Scope should send unknown methods to its owner" do
    published = Book.published
    Book.expects(:new)
    published.new
  end
end