Book.published.unpublished.new

published_invocation = Invocation.new(Book, :published)
Book.published => published_invocation

unpublished_invocation = Invocation.new(published_invocation, :unpublished)
published_invocation.unpublished => unpublished_invocation

unpublished_invocation.new

with_scope(:create, invoker.merge_scope(query_parameters)) do
  Book.send(:new)
end
