Rails.application.routes.draw do
  get 'messages/index'
  get 'conversations/index'
  root 'home#index'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords', confirmations: 'users/confirmations' }
  resources :campaigns
  put '/campaign/:id/like' => 'campaigns#like', :as => 'like'
  resources :projectchampions
  resources :categories
  resources :users
  resources :backers, only: [:create]
  resources :badges
  resources :campaignreviews
  put '/admin/campaign/:id/change' => 'admins#change_campaign_status', :as => 'change_campaign_status'
  put 'campaign/:id/milestone/:id/change' => 'users#change_milestone_status', :as => 'change_milestone_status'
  get '/user/:id/dashboard', to: 'users#dashboard', :as => 'dashboard'
  get '/user/:id/profile', to: 'users#profile', :as => 'profile'
  post '/hook' => 'projectchampions#hook'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :posts
  resources :comments
  get '/about', to: 'home#aboutus'
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
end
