require 'loader'

RSpec.configure do |config|
  config.before(:suite) do
    Machine::Repository::Change.clear!
  end

  config.before(:each) do
    Machine::Repository::Change.clear!
  end
end