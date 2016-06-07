class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validates :title, presence: true, length: {in: 10..50}
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 15.megabytes
        	errors.add(:picture, "should be less than 5MB")
      	end
  	end
end
