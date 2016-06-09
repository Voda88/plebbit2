require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @topic = @user.topics.create(title: "asdfsdafdafdsa",content: "lorem ipsum")
    @comment = @topic.comments.create(content: "asdfsafdsfas", topic_id: @topic.id, user_id: @user.id)
    @comment_comment=@comment.comments.create(content:"asdfafdsfasd", topic_id: @topic.id, user_id: @user.id)
  end

  test "should be valid" do
  	assert @comment_comment.valid?
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment_comment.user_id = @comment.user_id = nil
    assert_not @comment.valid?
    assert_not @comment_comment.valid?
  end

  test "topic id should be present" do
    @comment_comment.topic_id = @comment.topic_id = nil
    assert_not @comment.valid?
    assert_not @comment_comment.valid?
  end

  test "content should be present" do
    @comment.content = @comment_comment.content = "   "
    assert_not @comment.valid?
    assert_not @comment_comment.valid?
  end

  test "content should be at most 300 characters" do
    @comment.content = @comment_comment.content = "a" * 302
    assert_not @comment.valid?
    assert_not @comment_comment.valid?
  end

end
