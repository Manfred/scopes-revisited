class Book
  class << self
    attr_accessor :scope_stack
  end
  @scope_stack = []
  
  def self.with_scope(method, options={}, action=:merge, &block)
    self.scope_stack << [method, options]
    begin
      block.call
    ensure
      self.scope_stack.pop
    end
  end
  
  def self.find(action, options={})
    p scope_conditions(:find)
  end
  
  def self.scope_conditions(method)
    self.scope_stack.last
  end
end

Book.with_scope(:find, :conditions => { :published => true }) do
  Book.with_scope(:find, :conditions => { :author => 'Manfred' }) do
    Book.find(:all)
  end
end