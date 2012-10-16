require 'rubygems'
require 'bundler/setup'
require 'mongoid'
require 'mongoid/oslc'

require 'rspec'

Mongoid.configure do |config|
  config.connect_to('mongoid_oslc_where_test')
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.after(:each) { Mongoid.purge! }
end
