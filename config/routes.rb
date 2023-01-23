require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'

  resources :articles

    resources :accounts, only: [:show] do
      resource :follows, only: [:create]
      resource :unfollows, only: [:create]
    end

    scope module: :apps do
      resource :profile, only: [:show, :edit, :update]
      resource :timeline, only: [:show]
      resources :favorites, only: [:index]
    end

    namespace :api, defaults: {format: :json} do
      scope '/articles/:article_id' do
        resources :comments, only: [:index, :create]
        resource :like, only: [:show, :create, :destroy]
     end
  end
end
