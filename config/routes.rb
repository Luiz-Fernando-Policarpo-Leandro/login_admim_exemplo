Rails.application.routes.draw do
  resources :administradors
  root to: 'administradors#index'
  get '/login', to: 'login#index'
  post '/login/on', to: 'login#login'
  get '/logout', to: 'login#logout'

end
