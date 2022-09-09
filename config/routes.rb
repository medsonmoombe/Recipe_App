Rails.application.routes.draw do
  devise_for :user
  root 'recipe#index'
  
  resources :users, only: [:index, :show] do
    resources :recipe, only: [:index, :new, :show, :create, :destroy]
    resources :inventories, controller: 'inventory', only: [:index, :show, :new, :create, :destroy]
  end

  patch '/recipes/:id', to: 'recipe#toggle_public', as: :update_recipe
  get '/public_recipes', to: 'recipe#public_recipes', as: :public_recipes

  resources :recipe, only: [:index, :show, :destroy] do
    resources :recipe_foods, only: [:create, :new, :edit, :update, :destroy]
  end

end