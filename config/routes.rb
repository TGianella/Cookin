Rails.application.routes.draw do
  root 'masterclasses#index'

  devise_for :users

  resources :masterclasses, param: 'title', only: %i[index new create update destroy] do
    resources :meetings, shallow: true do
      resources :reservations, shallow: true
    end
  end

  resources :recipes, param: 'title', only: %i[index new create edit update destroy]
  resources :chefs, param: 'name' do
    resources :recipes, param: 'title', only: %i[index], controller: 'chef/recipes'
    resources :recipes, param: 'title', only: %i[show]
    resources :masterclasses, param: 'title', only: %i[index], controller: 'chef/masterclasses'
    resources :masterclasses, param: 'title', only: %i[show]
  end

  namespace :chef do
    resources :recipes, param: 'title', except: %i[show index new create]
    resources :masterclasses, param: 'title', except: %i[show index new create]
    resources :masterclasses, param: 'title', only: %i[index], as: :my_masterclasses
    resources :meetings
    resources :reservations
  end

  namespace :guest do
    resources :recipes, param: 'title', only: %i[show index]
    resources :masterclasses, param: 'title', only: %i[show index]
    resources :reservations
    resources :profiles, param: 'name', only: %i[show update edit]
  end
end
