Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :my_words, only: [:destroy]

  match "/react" => "home#react", via: [:get]
  match "/my_words" => "home#my_words", via: [:get]
  match "/search" => "home#search", via: [:get]
  match "/save" => "home#save", via: [:post]
  root "home#index"
end
