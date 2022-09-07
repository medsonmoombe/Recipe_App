class RecipeController < ApplicationController
  def index
    @recipe = Recipe.new
  end

  def show
  end
end
