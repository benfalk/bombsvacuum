BombsVacuum::Application.routes.draw do

  resources :fields, :except => [:edit,:update,:patch] do
    resources :locations, :only => [:patch,:update,:show]
  end

  root 'fields#index'

end
