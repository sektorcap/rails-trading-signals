Rails.application.routes.draw do
  get 'stock_signals/index'
  resources :stocks
  root to: 'stock_signals#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
