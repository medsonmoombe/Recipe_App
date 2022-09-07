class RecipeController < ApplicationController

  def index
    @current_user = current_user
    if @current_user.nil?
      redirect_to user_sesssion_path, flash: { alert: 'You must be signed.'}
    else
    @recipes = current_user.recipe.order(created_at: :desc)
  end

  def show
   @recipe = Recipe.includes(:recipe_foods).find(params[:id])
   @current_user = current_user
  end

  def new
    @recipe = Recipe.new
    # @params = params
    @foods = Food.all
    @recipe.recipe_foods.build
  end

  def create
   @recipe = Recipe.new(recipe_params)
   if @recipe.save
    flash[:notice] = 'Recipe has been successfully added!'
    redirect_to  user_recipes_path
    else
      flash[:alert] = 'An error occurred while creating a recipe'
      redirect_to :new
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
     
    if @recipe.user == current_user
      @recipe.destroy
      flash[:notice] = 'Recipe has successfully been deleted!'
      redirect_to user_recipes_path
    else
      return
    end
  end

  def toggle_recipe
    @recipe = set_recipe
    @recipe.public = !@recipe.public 
    text = 'private'
    text = 'public' if @recipe.public
    if @recipe.save
      flash[:success] = "#{@recipe.name} is now #{text}!"
    else
      flash[:fail] = @recipe.public
    end
    redirect_to recipe_path(@recipe.id)

  end

  def public_recipes
    @recipes = Recipe.where(public: true)
  end


  def 

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public)
  end
end
