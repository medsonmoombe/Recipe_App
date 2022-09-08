class InventoryController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @inventories = @user.Inventories.all
  end

  def show
    @inventory = Inventory.includes(:user).find(params[:id])
  end

  def new
    @user = current_user
    @inventory = @user.Inventory.new
  end

  def create
    @inventory = Inventory.create(inventory_params)
    @inventory.user = current_user
    respond_to do |format|
      format.html do
        if @inventory.save
          flash[:success] = 'Inventory has been created'
          #  redirect_to inventories_path(current_user, @inventory)
        else
          flash.now[:error] = 'Error: Inventory could not created'
        end
      end
    end
  end

  def destroy
    @inventory = Inventory.includes(:user).find(params[:id])
    @inventory.destroy
    flash[:success] = 'You have deleted your Inventory!!.'
    #  redirect_to inventories_path(current_user, @inventory)
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name)
  end
end
