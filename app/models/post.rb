class Post < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :most_likes, ->{where like_quantity: self.maximum(:like_quantity)}
  scope :other_posts, ->(id){where.not id: id}
  scope :all_posts, ->{select(:id, :title, :sumary, :picture, :content).where(status: 1).order created_at: :desc}
  POST_PARAMS = [:title, :content, :sumary, :picture].freeze

  scope :by_lastest, -> {order created_at: :desc}

  validate  :picture_size
  validates :title, presence: true, length: {maximum: Settings.max_title_length}
  validates :content, presence: true,
    length: {minimum: Settings.min_content_length}
  validates :sumary, presence: true,
    length: {maximum: Settings.max_sumary_length}

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > Settings.size_picture.megabytes
      errors.add(:picture, I18n.t(".should_be_less_than_5MB"))
    end
  end
end
