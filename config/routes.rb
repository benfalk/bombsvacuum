BombsVacuum::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :fields, :except => [:edit,:update,:patch] do
    resources :locations, :only => [:patch,:update,:show]
  end

  resources :field_subscriptions, :only =>[:show]

  # You can have the root of your site routed with "root"
  root 'fields#index'



end
