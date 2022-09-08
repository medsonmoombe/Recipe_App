class RecipeFoodController < ApplicationController
  def new
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @food = @user.foods
    @recipe_foods = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.new(recipe_food_params)
    if recipe_food.save
      flash[:notice] = 'recipe food successfully created!'
      redirect_to @recipe
    else
      render :new
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if recipe_food.update(recipe_food_params)
      flash[:success] = 'Recipe foood successfully updated!'
      redirect_to (@recipe_food.recipe)
    else
      flash[:alert] = 'Recipe food failed to update!'
      redirect_to :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
    @recipe_food.destroy
    respond_to do |format|
      format.html { redirect_to recipe_path(@recipe.id), notice: 'Recipe food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
