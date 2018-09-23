Rails.application.routes.draw do
  resources :categories
  get 'category/new'
  get 'category/create'
  get 'category/destroy'
  get 'category/update'
  root 'posts#index', as: 'posts_index'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
