require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'webmock/rspec'

require 'insightexchange'


RSpec.configure do |config|
  # some (optional) config here

  config.treat_symbols_as_metadata_keys_with_true_values = true

end
