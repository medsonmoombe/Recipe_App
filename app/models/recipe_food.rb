class RecipeFood < ApplicationRecord
  belongs_to :food, class_name: 'Food'
  belongs_to :recipe, class_name: 'Recipe'

  validates :quantity, presence: true, numericality: { great_than_or_eaqual_to: 0 }
end
