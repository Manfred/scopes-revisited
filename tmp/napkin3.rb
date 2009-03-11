Book.published.unpublished.new

book.published.authors.unpublished.build

ws(:p => true) do
  ws(:p => false) do
    Book.new
  end
end

# Scope
def merge_parents(options)
  scope_options = parent.merge_parents({})
  scope_options = scope_options.merge(scope_options)
  scope_options
end

def mm(method)
  if is_scope?(method)
    Scope.new(self)
  else
    ws(merge_parents) do
      Book.send(method)
    end
  end
end

# Association proxy
def merge_parents(options)
  scope_options = parent.merge_parents(scope_options)
  scope_options
end

