Rails.application.routes.draw do
  mount JasmineRails::Engine => '/jasmine' if defined?(JasmineRails)

  root to: 'home#index'

  namespace :api, defaults: {format: :json} do
    resource :session, only: [:create, :destroy]
    resource :users,   only: [:show]
  end

  constraints format: 'html' do
    get '*path', controller: 'home', action: 'index'
  end
end
