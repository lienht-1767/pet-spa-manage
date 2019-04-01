class Service < ApplicationRecord
  has_many :order_details

  enum status: {Public: 1, Pending: 0}

  SERVICE_PARAMS = [:name, :status, :price, :picture, :description].freeze

  validate  :picture_size
  validates :name, presence: true, length: {maximum: Settings.max_service_name}
  validates :price, presence: true, numericality: {only_float: true}
  validates :status, presence: true

  mount_uploader :picture, PictureUploader

  scope :all_services, ->{select :id, :name, :description, :price}
  scope :other_services, ->(id){where.not id: id}
  scope :by_lastest, ->{order created_at: :desc}
  scope :public_service, ->{where status: 1}

  private
  def picture_size
    return unless picture.size > Settings.size_picture.megabytes
    errors.add(:picture, I18n.t(".should_be_less_than_5MB"))
  end
end
