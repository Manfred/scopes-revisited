class Book < ActiveRecord::Base
  named_scope :published, :conditions => { :published => true }
  named_scope :draft, :conditions => { :published => true }
end