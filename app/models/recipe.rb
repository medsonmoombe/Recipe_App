class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :recipe_food, class_name: "RecipeFood", dependent: :destroy
  has_many :food, through: :recipe_food

  validates :name, presence: true
  validates :public, inclusion: { in: [true, false] }
end
