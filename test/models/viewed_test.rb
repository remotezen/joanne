require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ViewedTest < Test::Unit::TestCase
  context "Viewed Model" do
    should 'construct new instance' do
      @viewed = Viewed.new
      assert_not_nil @viewed
    end
  end
end
