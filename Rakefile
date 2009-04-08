require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/cases/*_test.rb']
  t.verbose = true
  t.warning = true
end

begin
  require 'rubygems'
  require 'discount'
  
  desc "Convert README.markdown to an HTML file"
  task :readme do
    discount = Discount.new(File.read(File.expand_path('../README.markdown', __FILE__)))
    File.open(File.expand_path('../README.html', __FILE__), 'w') { |file| file.write(discount.to_html) }
  end
rescue LoadError
end