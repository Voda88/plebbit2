class Vote < ActiveRecord::Base
	belongs_to :voteable, polymorphic: true
	validates_uniqueness_of :user_id, scope: [:voteable_id, :voteable_type]

	def count_upvotes_for_voteable(voteable)
		Vote.where(voteable_id: voteable.id, voteable_type: voteable, number: 1).sum(:number)
	end

	def count_downvotes_for_voteable(voteable)
		Vote.where(voteable_id: voteable.id, voteable_type: voteable, number: -1).sum(:number)
	end

	def count_karma
		Vote.where(voteable_id: voteable.id, voteable_type: voteable).sum(:number)
	end
end
