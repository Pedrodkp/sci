Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  
  resources :taxonomies      

  resources :articles do
    resources :article_likes
    resources :article_histories
    resources :relationships
  end
  
  resources :posts do
    resources :comments
  end
end
