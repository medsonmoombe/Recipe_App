class RecipeFoodController < ApplicationController
  before_action :authenticate_user!
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    if @recipe_food.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(recipe_food_params)
      flash[:succes] = 'Recipe food updated successfully'
      redirect_to recipe_path(@recipe_food.recipe)
    else
      flash[:succes] = 'Recipe food update failed'
      render :edit
    end
  end

  def shopping_list
    foods = Food.includes(:recipes).where(user: current_user)
    @filter_food = foods.filter { |food| food.recipes.blank? }
    @total = @filter_food.sum(&:price)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
