class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :index, :destroy]
	before_action :admin_user, only: :destroy

	def show
		@user=current_user
	end

	def new	
		@user=current_user
		@comment=Comment.new
		find_commentable
	end

	def create
		@user=current_user
		@comment= @@commentable.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment successful!"
			redirect_to Topic.find_by_id(@comment.topic_id)
		else
			render 'new'
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
    	flash[:success] = "Comment deleted"
    	redirect_to users_url
	end


	private

	def comment_params
		params.require(:comment).permit(:content, :picture, :topic_id, :user_id)
	end

    def find_commentable
    	@@commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      	@@commentable ||= Topic.find_by_id(params[:topic_id]) if params[:topic_id]
    end
end
