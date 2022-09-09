class FoodsController < ApplicationController
  def index
    @foods = current_user.foods.includes(:user).all
  end

  def show
    @food = current_user.foods.includes(:user).find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user
    if @food.save
      flash[:success] = 'New inventory has been created !!'
      redirect_to foods_path
    else
      flash['alert'] = 'Inventory could not created !!'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    flash[:success] = 'Inventory has been deleted successfully'
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end