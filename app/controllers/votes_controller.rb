class VotesController < ApplicationController

	def create
		@voteable=
	end

	def update
	end

	def delete
	end

	private
	def vote_params
		params.require(:vote).permit(:number)
	end
	
end
