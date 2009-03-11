require "thread"

require "rubygems"
require "active_support"

class Book
  def self.with_scope(method, options = {}, action = :merge, &block)
    merged_scope_options = (Thread.current[:block_scope_options] || {}).deep_merge(options)
    Thread.new do
      Thread.current[:block_scope_options] = merged_scope_options
      block.call
    end.join
  end
  
  def self.find(action, options={})
    sleep 1
    p Thread.current[:block_scope_options]
  end
end
 
Book.with_scope(:find, :conditions => { :published => true }) do
  Book.with_scope(:find, :order => 'name ASC') do
    Book.find(:all)
  end
  
  Book.with_scope(:find, :conditions => { :author => 'Manfred' }) do
    Book.with_scope(:find, :order => 'name ASC') do
      Book.find(:all)
    end
  end
end