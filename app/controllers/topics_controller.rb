class TopicsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :admin_user, only: :destroy

	def index
		@topics=Topic.paginate(page: params[:page])
	end

	def show
		@topic=Topic.find(params[:id])
	end

	def new
		@topic=Topic.new
		@user=current_user
	end

	def create
		@user=current_user
		@topic=current_user.topics.build(topic_params)
		if @topic.save
			flash[:success] = "Post successful!"
			redirect_to @topic
		else
			render 'new'
		end
	end

	def destroy
		Topic.find(params[:id]).destroy
    	flash[:success] = "Topic deleted"
    	redirect_to users_url
	end


	private

	def topic_params
		params.require(:topic).permit(:content, :title, :picture, :user_id, :topic_id)
	end

	def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end
end
