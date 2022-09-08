class InventoryFoodController < ApplicationController
  def create
    @food = Food.includes(:user).find(params[:food_id])
    @inventory_food = InventoryFood.create(inventory_params)
    @inventory_food.user = current_user
    if @inventoryFood.save
      flash[:success] = 'New inventory food has been created !!'
      redirect_to inventory_path(params[:id])
    else
      flash[:error] = 'Inventory could not created !!'
      render :new
    end
  end

  def destroy
    @inventory_food = InventoryFood.find(params[:id])
    @inventory_food.destroy
    flash[:success] = 'Inventory has been deleted successfully'
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
