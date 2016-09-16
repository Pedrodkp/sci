Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :relationships
  resources :taxonomies
  resources :articles do
  	member do
  	  get 'like'
  	end
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :posts
end
