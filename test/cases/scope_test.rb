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

  test "Scope should append its query parameters to the scope stack before running a Base method" do
    book = Book.draft.new
    assert_equal false, book.attributes[:published]
  end

  test "Chained scopes should merge additional query parameters before running a Base method" do
    book = Book.draft.published.new
    assert_equal true, book.attributes[:published]
  end

  test "Chained scopes should merge conflicting query parameters before running a Base method" do
    book = Book.published.negative_thinking.new
    assert_equal true, book.attributes[:published]
    assert_equal '978-0345508935', book.attributes[:isbn]
  end
end