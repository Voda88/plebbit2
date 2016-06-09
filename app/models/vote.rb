class Vote < ActiveRecord::Base
	belongs_to :voteable, polymorphic: true
	validates :vote, uniqueness: {scope: :user}
end
