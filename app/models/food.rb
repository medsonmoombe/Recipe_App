class Food < ApplicationRecord
  belongs_to :user, className: 'User', foreignKey: 'user_id'
  has_many :recipe_foods, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 250 }
  validates :measurement_unit, presence: true, length: { minimum: 1, maximum: 250, only_integer: true }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def update_price(price)
    self.price = price
    save
  end

  def update_measurement_unit(measurement_unit)
    self.measurement_unit = measurement_unit
    save
  end
end
