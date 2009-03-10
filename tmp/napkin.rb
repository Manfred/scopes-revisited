class Book
  def self.with_scope(method, options={}, action=:merge, &block)
    eval("@block_scope_options = #{options.inspect}", block.binding)
    block.call
  end
  
  def self.find(action, options={})
    p @block_scope_options
  end
end

Book.with_scope(:find, :conditions => { :published => true }) do
  Book.with_scope(:find, :conditions => { :author => 'Manfred' }) do
    Book.find(:all)
  end
end