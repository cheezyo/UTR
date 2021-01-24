Rails.application.routes.draw do
  
  resources :rankings 
  resources :ranking_imports do 
  	collection do 
  		post :import
      get :single
      get :double
  	end
  end
  resources :players do 
	collection do 	
		post :import
  	end
  end 
  root :to => 'ranking_imports#index'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
