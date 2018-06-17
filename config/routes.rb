Rails.application.routes.draw do
  get 'stock_signal_checks/index'
  get 'stock_signals/index(/:id)', to: 'stock_signals#index', as: 'stock_signals'
  # get 'stock_signals/index'
  resources :stocks
  root to: 'stock_signals#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
