class UsersController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end


  private

  def user_params
  	require(:user).permit(:first_name,:last_name,:email,:password)
  end
end
