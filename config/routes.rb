Rails.application.routes.draw do
  get 'article_histories/index'

  mount Ckeditor::Engine => '/ckeditor'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  
  resources :articles do
    resources :article_likes
    resources :article_histories
    resources :relationships
    resources :taxonomies    
  end
  
  resources :posts do
    resources :comments
  end
end
