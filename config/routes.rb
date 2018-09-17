Rails.application.routes.draw do
  root 'posts#index', as: 'posts_index'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
