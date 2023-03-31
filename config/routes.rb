Rails.application.routes.draw do
 
  root 'masterclasses#index'

  get 'pages/about'
  get 'pages/contact'

  devise_for :users

  resources :masterclasses, param: 'title', except: :show do
    resources :meetings, shallow: true do
      resources :reservations, shallow: true
    end
  end

  resources :recipes, param: 'title', except: :show
  resources :chefs, param: 'name', except: %i[new create destroy] do
    resources :recipes, param: 'title', only: %i[index], controller: 'chef/recipes'
    resources :recipes, param: 'title', only: %i[show]
    resources :masterclasses, param: 'title', only: %i[index], controller: 'chef/masterclasses'
    resources :masterclasses, param: 'title', only: %i[show]
  end

  namespace :chef do
    resources :recipes, param: 'title', only: :index
    resources :masterclasses, param: 'title', only: :index
    resources :reservations, only: :index
  end

  namespace :guest do
    resources :recipes, param: 'title', only: :index
    resources :masterclasses, param: 'title', only: :index
    resources :reservations, only: :index
    resources :profiles, param: 'name', only: %i[show update edit]
  end
end
