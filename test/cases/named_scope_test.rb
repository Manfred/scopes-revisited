require File.expand_path('../../test_helper', __FILE__)
require 'models/book'

class NamedScopeTest < ActiveSupport::TestCase
  test "named scope methods should instantiate a Scope" do
    assert Book.published.kind_of?(ActiveRecord::Scoping::Scope)
  end
end