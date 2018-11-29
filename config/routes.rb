Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations' }
  resources :campaigns
  resources :projectchampions
  resources :categories
  resources :users
  put '/admin/campaign/:id/changed' => 'admins#change_campaign_status', :as => 'change_campaign_status'
  get '/user/:id/dashboard', to: 'users#dashboard', :as => 'dashboard'
  get '/user/:id/profile', to: 'users#profile', :as => 'profile'
  post '/hook' => 'projectchampions#hook'
end
