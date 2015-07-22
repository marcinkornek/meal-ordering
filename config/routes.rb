Rails.application.routes.draw do
  mount JasmineRails::Engine => '/jasmine' if defined?(JasmineRails)

  root to: 'home#index'

  namespace :api, defaults: {format: :json} do
    resource :session,    only: [:create, :destroy]
    resource :users,      only: [:show]
    resources :consumers, only: [:index, :show, :create, :update, :destroy]
    resources :orders,    only: [:index, :show, :create, :update, :destroy]
  end

  get '/api/remaining_consumers' => 'api/consumers#remaining_consumers'
  post '/api/order_deliver'      => 'api/orders#deliver'

  constraints format: 'html' do
    get '*path', controller: 'home', action: 'index'
  end
end
