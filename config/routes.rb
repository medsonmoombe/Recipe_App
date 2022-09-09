Rails.application.routes.draw do
  # get 'foods/index'
  # get 'foods/new'
  devise_for :users

  root 'users#index'

  resources :users, only: [:index, :show] do
    resources :recipe, only: [:index, :new, :show, :create, :destroy]
  end

  resources :foods, only: [:index, :new, :show, :create, :destroy] do
  end

  patch '/recipes/:id', to: 'recipe#toggle_public', as: :update_recipe
  get '/public_recipes', to: 'recipe#public_recipes', as: :public_recipes

  resources :recipe, only: [:index, :show, :destroy] do
    resources :recipe_foods, only: [:create, :new, :edit, :update, :destroy]
  end

end
