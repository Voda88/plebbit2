class User < ActiveRecord::Base
	has_secure_password
	before_save { email.downcase! }
	validates :first_name, presence: true, length: {maximum: 50}
	validates :last_name, presence: true, length: {maximum:50}
	validates :email, 
					presence: true, 
					length: {maximum:50}, 
					format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}, 
					uniqueness: {case_sensitive: false}
					
	validates :password, presence: true, length: {in: 7..20}
end
