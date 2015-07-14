require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "Hello")
  end
  
  test "should be valid" do
    assert @micropost.valid?
  end
  
  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "micropost content should be present" do
    @micropost.content = "  "
    assert_not @micropost.valid?
  end
  
  test "micropost content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
  
  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end
  
end
