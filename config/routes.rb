BombsVacuum::Application.routes.draw do


  resources :fields, :except => [:edit,:update,:patch] do
    resources :locations, :only => [:patch,:update,:show]
  end

  # You can have the root of your site routed with "root"
  root 'board#index'


  # root 'fields#index'

end
