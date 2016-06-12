class VotesController < ApplicationController
	before_action :logged_in_user, only: [:create]

	def create
		@user=current_user
		find_voteable
		@vote=@voteable.votes.build(vote_params)
		unless @voteable.user_id == @user.id
			if @vote.save
				flash[:success] = "succesful vote"
				redirect_to :back
			else
				flash[:danger] = "You have already voted"
				redirect_to :back
			end	
		else
			flash[:danger] = "You cannot vote on your own posts"
			redirect_to :back
		end
	end

	def update
	end

	def delete
	end

	private

	def vote_params
		params.require(:vote).permit(:number, :user_id, :voteable_id, :voteable_type)
	end

	def find_voteable
		@voteable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      	@voteable ||= Topic.find_by_id(params[:topic_id]) if params[:topic_id]
	end
end
