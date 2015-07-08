Rails.application.routes.draw do
  root to: 'home#index'

  constraints format: 'html' do
    get '*path', controller: 'home', action: 'index'
  end
end
