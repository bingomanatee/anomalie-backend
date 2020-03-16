Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dress_types
  resources :dress_types_bad_combos
  resources :dresses
end
