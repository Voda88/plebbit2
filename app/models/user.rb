class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token
	has_secure_password
	before_save { email.downcase! }
	before_create :create_activation_digest
	validates :first_name, presence: true, length: {maximum: 50}
	validates :last_name, presence: true, length: {maximum:50}
	validates :email, 
					presence: true, 
					length: {maximum:50}, 
					format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}, 
					uniqueness: {case_sensitive: false}
					
	validates :password, presence: true, length: {in: 7..20}, allow_nil: true
	#Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	 # Returns true if the given token matches the digest.
  	def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
  	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	private

	# Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

	# Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
