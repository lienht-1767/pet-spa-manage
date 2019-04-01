class Pet < ApplicationRecord
  has_many :order_details

  PET_PARAMS = [:name, :description].freeze

  validates :name, presence: true, length: {maximum: Settings.max_name_lenght}
  validates :description, presence: true,
    length: {maximum: Settings.max_sumary_length}

  scope :by_lastest, -> {order created_at: :desc}
  scope :all_pets, ->{select :id, :name}
end
