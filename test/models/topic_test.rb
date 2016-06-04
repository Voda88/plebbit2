require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @topic = @user.topics.build(title: "asdfsdafdafdsa",content: "lorem ipsum")
  end

  test "should be valid" do
    assert @topic.valid?
  end

  test "user id should be present" do
    @topic.user_id = nil
    assert_not @topic.valid?
  end

  test "title should present" do
    @topic.title= "   "
    assert_not @topic.valid?
  end
 
  test "content should be present" do
    @topic.content = "   "
    assert_not @topic.valid?
  end

  test "content should be at most 300 characters" do
    @topic.content = "a" * 302
    assert_not @topic.valid?
  end

  test "order should be most recent first" do
    assert_equal topics(:most_recent), Topic.first
  end
end
