require File.expand_path('../test_helper', __FILE__)

class Book
  def find(action, options={})
    options = scope_options(:find).merge(options)
    sql = construct_sql_for(action, options)
    find_by_sql(sql)
  end
end

Book.with_scope(:find, :conditions => { :published => true }) do
  Book.with_scope(:find, :conditions => { :author => 'Manfred' }) do
    Book.find(:all)
  end
end