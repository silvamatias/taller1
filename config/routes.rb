Rails.application.routes.draw do
resources :films
resources :planets
resources :characters
resources :starships

root 'films#index'  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
