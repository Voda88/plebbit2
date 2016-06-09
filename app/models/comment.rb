class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 15.megabytes
        	errors.add(:picture, "Should be less than 15MB!")
      	end
  	end
end
