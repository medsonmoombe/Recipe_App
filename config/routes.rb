Rails.application.routes.draw do
  devise_for :users
  
  resources :recipe, only: %i[index show new create destroy put] do
    resources :recipe_foods, path: 'food', only: %i[destroy new create]
  end

  match 'recipes/:recipe_id' => 'recipe#toogle_public', as: :toogle_public, via: :patch
  match 'public_recipes' => 'recipe#public_recipes', as: :public_recipes, via: :get

  root 'recipe#public_recipes'
end
