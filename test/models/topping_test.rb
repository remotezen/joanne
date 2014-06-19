require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ToppingTest < Test::Unit::TestCase
  context "Topping Model" do
    should 'construct new instance' do
      @topping = Topping.new
      assert_not_nil @topping
    end
  end
end
