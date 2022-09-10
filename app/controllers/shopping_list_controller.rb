class ShoppingListController < ApplicationController
  def index
    @shopping_list = Food.all
  end
end
