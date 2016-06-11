module SessionsHelper

	def log_in(user)
		session[:user_id]= user.id
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] =user.remember_token
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember)
	end

	def current_user
		if (user_id = session[:user_id]) 
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id=cookies.signed[:user_id])
			user= User.find_by(id: user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

	def current_user?(user)
		user == current_user
	end

	def logged_in?
		!current_user.nil?
	end
	
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	def full_name(user)
		"#{user.first_name} #{user.last_name}"
	end

	#comment params
	def post_params(post)
		if post.is_a?(Topic)
			post = {topic_id: post.id}
		elsif post.is_a?(Comment)
			post = {topic_id: post.topic_id, comment_id: post.id}
		end
	end

	#voting

	def count_upvotes_for_voteable(voteable_id, voteable_type)
		Vote.where(voteable_id: voteable_id, voteable_type: voteable_type, number: 1).sum(:number)
	end

	def count_downvotes_for_voteable(voteable_id, voteable_type)
		Vote.where(voteable_id: voteable_id, voteable_type: voteable_type, number: -1).sum(:number)
	end


	def Topic_helper(user)
		Topic.where(user_id:user.id).pluck(:id)
	end

	def Comment_helper(user)
		Comment.where(user_id:user.id).pluck(:id)
	end

	def count_voteable_upvotes_for_user(user,attribute)
		voteables=send("#{attribute}_helper", user)
		sum=0
		voteables.each do |t|
			sum+=count_upvotes_for_voteable(t, attribute)
		end
		return sum
	end

	def count_voteable_downvotes_for_user(user,attribute)
		voteables=send("#{attribute}_helper", user)
		sum=0
		voteables.each do |t|
			sum+=count_downvotes_for_voteable(t, attribute)
		end
		return sum
	end

	def has_voted(voteable)
		if logged_in?
			if !Vote.where(voteable_id: voteable.id, voteable_type: voteable.class.name, user_id:@user.id, number: 1).empty?
				return 'upvoted'
			elsif !Vote.where(voteable_id: voteable.id, voteable_type: voteable.class.name, user_id:@user.id, number: -1).empty?
				return 'downvoted'
			end
		end
	end

	private

	def logged_in_user
    	unless logged_in?
     	 	store_location
     	 	flash[:danger] = "Please log in"
     	 	redirect_to login_url
   	 	end
  	end

  	def admin_user
    redirect_to(root_url) unless current_user.admin?
  	end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
