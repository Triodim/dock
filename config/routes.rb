Rails.application.routes.draw do

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end


  resources :users #, only: [:show, :update, :index, :create, :new]



  resources :categories

  resources :posts

  root 'posts#index', as: 'posts_index'

end
