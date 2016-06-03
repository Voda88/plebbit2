require 'test_helper'

class UserTest < ActiveSupport::TestCase
 	def setup
  		@user=User.new(	first_name:"Example", 
  						last_name:"User", email:"example@example.com",
  						password:"password", 
  						password_confirmation:"password")
  	end

 	test "should be valid" do
 		assert @user.valid?
	end

	test "First Name should be present" do
		@user.first_name = "       "
		assert_not @user.valid?
	end

	test "first name shouldn't be too long" do
		@user.first_name = 'a'*51
		assert_not @user.valid?
	end

	test "Last Name should be present" do
		@user.last_name = "       "
		assert_not @user.valid?
	end

	test "Last name shouldn't be too long" do
		@user.last_name = 'a'*51
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "    "
		assert_not @user.valid?
	end

	test "email shouldn't be too long" do
		@user.last_name = 'a'*51
		assert_not @user.valid?
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com fooasdf@asdf..com]
    	invalid_addresses.each do |a|
    		@user.email = a
      		assert_not @user.valid?, "#{a.inspect} should be invalid"
		end
	end

	test "email validation should accept valid address" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |a|
        	@user.email = a
        	assert @user.valid?, "#{a.inspect} should be valid"
        end
	end

	test "email addresses should be unique" do
		duplicate_user=@user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower case" do
		other_user=User.new(first_name:"a",
							last_name:"a",
							email:"ASDF@ASDF.com",
							password:"asdfasdf",
							password_confirmation:"asdfasdf")
		other_user.save
		assert_equal other_user.email, 'asdf@asdf.com'
	end


	test "password should be present" do
		@user.password = @user.password_confirmation = "         "
		assert_not @user.valid?
	end

	test "password shouldn't be too long " do
		@user.password = @user.password_confirmation = 'a'*51
		assert_not @user.valid?
	end

	test "password shouldn't be too short " do
		@user.password = @user.password_confirmation = 'a'*6
		assert_not @user.valid?
	end

	test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember, '')
	end

	
end
