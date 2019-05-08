Rails.application.routes.draw do
  get 'users/login', to: 'login#new'
  post 'users/login', to: 'login#create'
  get '/users/logout', to: 'login#destroy'
  post '/users/logout', to: 'login#destroy'
  namespace :api do
    resources :posts
    resources :tags
    resources :words do
      collection do
        post :create, via: :options
      end
    end
    resources :diaries do
      member do
        get :next
        get :prev
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  # resources :posts

  get '*path', to: 'home#index', constraints: -> (request) do
    !request.url.include?('/packs') and
        !request.url.include?('favicon.ico') and
        !request.url.include?('robots')
  end

end
