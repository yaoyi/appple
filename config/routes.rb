Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :my_words

  match "/search" => "home#search", via: [:get]
  match "/save" => "home#save", via: [:post]
  root "home#index"
end
