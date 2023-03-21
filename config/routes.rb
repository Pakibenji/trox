Rails.application.routes.draw do

  devise_for :users , controllers: {sessions:'users/sessions'}
  resources :loans
  resources :tools
  get 'about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
