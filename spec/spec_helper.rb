require 'loader'

RSpec.configure do |config|
  config.before(:suite) do
    Machine::Repository::Change.clear!
    Machine::Repository::Product.clear!
  end

  config.before(:each) do
    Machine::Repository::Change.clear!
    Machine::Repository::Product.clear!
  end
end