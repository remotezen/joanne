require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class UploadTest < Test::Unit::TestCase
  context "Upload Model" do
    should 'construct new instance' do
      @upload = Upload.new
      assert_not_nil @upload
    end
  end
end
