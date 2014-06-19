require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class LocationTest < Test::Unit::TestCase
  context "Location Model" do
    should 'construct new instance' do
      @location = Location.new
      assert_not_nil @location
    end
  end
end
