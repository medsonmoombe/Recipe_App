Rails.application.routes.draw do
  devise_for :user
  root 'recipe#index'

  resources :users, only: [:index, :show] do
    resources :recipe, only: [:index, :new, :show, :create, :destroy]
    resources :inventories, controller: 'inventory', only: [:index, :show, :new, :create, :destroy]
    resources :inventories, controller: 'inventory', only: [:index, :show, :new, :create, :destroy] do
      resources :foods, only: [:index, :show, :new, :create, :destroy] do
        resources :inventory_food, only: [:new, :create, :destroy]
      end
    end
  end

  post 'inventory_foods/:id/create', to: 'inventory_food#create'
  get 'inventory_food/:id/new', to: 'inventory_food#new'

  post 'shopping_list/:recipe_id', to: 'shopping_lists#generate'
  get 'shopping_list', to: 'shopping_lists#show'
  
  resources :foods, only: [:index, :show, :new, :create, :destroy]

  patch '/recipes/:id', to: 'recipe#toggle_public', as: :update_recipe
  get '/public_recipes', to: 'recipe#public_recipes', as: :public_recipes

  resources :recipe, only: [:index, :show, :destroy] do
    resources :recipe_food, only: [:create, :new, :edit, :update, :destroy]
  end
end
