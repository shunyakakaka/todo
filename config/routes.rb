Rails.application.routes.draw do
  get 'boards/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "boards", to: "boards#index"
end
