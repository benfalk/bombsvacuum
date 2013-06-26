BombsVacuum::Application.routes.draw do

  devise_for :users

  resources :fields, :except => [:edit,:update,:patch] do
    resources :locations, :only => [:patch,:update,:show]
  end

  # You can have the root of your site routed with "root"
  root 'fields#index'

end
