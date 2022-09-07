class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 250 }
  validates :measurement_unit, presence: true, length: { minimum: 1, maximum: 250 }
  validates :price, presence: true, numericality: { greater_than: 0 }

  def update_price(price)
    self.price = price
    save
  end

  def update_measurement_unit(measurement_unit)
    self.measurement_unit = measurement_unit
    save
  end
end
