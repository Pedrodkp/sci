Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :relationships
  resources :taxonomies
  resources :articles do
    resources :article_likes
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :posts do
      resources :comments
  end
end
