class Book < ActiveRecord::Base
  named_scope :published, :conditions => { :published => true }
  named_scope :draft, :conditions => { :published => false }
  named_scope :negative_thinking, :conditions => { :isbn => '978-0345508935' }
end