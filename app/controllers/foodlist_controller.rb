class FoodlistController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @foods = @user.foods.includes(:user)
  end

  def new
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to user_foodlist_index_path(current_user.id), notice: 'Food was successfully created'
    else
      render :new, alert: 'Error: Food not saved'
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
