class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validates :title, presence: true, length: {in: 1..50}
  validate :picture_size

  private
  	def picture_size
  		if picture.size > 15.megabytes
        	errors.add(:picture, "Should be less than 15MB!")
      	end
  	end
end
