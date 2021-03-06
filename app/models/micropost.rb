class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  
  private
  
    # Validates the size of uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "Picture must be less than 5 MB")
      end
    end
end
