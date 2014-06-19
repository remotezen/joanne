require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class LoginTest < Test::Unit::TestCase
  context "Login Model" do
    should 'construct new instance' do
      @login = Login.new
      assert_not_nil @login
    end
  end
end
