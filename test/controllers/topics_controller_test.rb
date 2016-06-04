require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  def setup
  	@admin=users(:michael)
  	@non_admin=users(:archer)
  end

  test "should redirect index when not logged in" do
  	get :index, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get index when logged in" do
  	log_in_as @non_admin
  	get :index
    assert_template 'topics/index'
  end

  test "should redirect new when not logged in" do
  	get :new
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

end
