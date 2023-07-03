Rails.application.routes.draw do
  post '/signup', to: 'user#create'
  post '/login', to: 'sessions#create'
  get '/me', to: 'user#show'
  delete '/logout', to: 'sessions#destroy'
end
