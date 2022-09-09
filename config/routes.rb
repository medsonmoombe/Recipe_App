Rails.application.routes.draw do
  devise_for :user
  root 'recipe#index'

  resources :users, only: [:index, :show] do
    resources :recipe, only: [:index, :new, :show, :create, :destroy]
    resources :inventories, controller: 'inventory', only: [:index, :show, :new, :create, :destroy]
  end

  resources :foods, only: [:index, :show, :new, :create, :destroy]

  patch '/recipe/:id', to: 'recipe#toggle_public', as: :update_recipe

  resources :recipe, only: [:index, :show, :destroy] do
    resources :recipe_food, only: [:create, :new, :edit, :update, :destroy]
  end
end
