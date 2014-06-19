require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class CounterTest < Test::Unit::TestCase
  context "Counter Model" do
    should 'construct new instance' do
      @counter = Counter.new
      assert_not_nil @counter
    end
  end
end
