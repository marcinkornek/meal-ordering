Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, defaults: {format: :json} do
    resource :session, only: [:destroy]
  end

  get '/auth/:provider/callback' => 'api/sessions#oauth', as: :oauth

  constraints format: 'html' do
    get '*path', controller: 'home', action: 'index'
  end
end
