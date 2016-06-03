require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "valid signup information" do
    get signup_path
    	assert_difference 'User.count', 1 do
     	post_via_redirect users_path, user: { first_name:  "Example User",
      										last_name: "asdfasdf",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    	end
    assert_template 'users/show'
    assert_not flash.empty?
  	end

	test "Invalid signup information" do
		get signup_path
		assert_template "users/new"
  		assert_no_difference 'User.count' do
  		post users_path, user: {first_name: "",
  								last_name: "asddfsafsaf",
  								email:"user@invalid.com",
  								password:"asdfasdf",
  								password_confirmation:"asdfasdf"}
  		end
  		assert_select 'div#error_explanation'
    	assert_select 'div.alert-danger'
	end
end
