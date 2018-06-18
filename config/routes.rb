Rails.application.routes.draw do
  get 'stock_signal_checks/index'
  get 'stock_signals/index(/:check_id)', to: 'stock_signals#index', as: 'stock_signals'
  get 'stock_signals/full(/:check_id)', to: 'stock_signals#full', as: 'stock_signals_full'
  get 'stock_signals/compact(/:check_id)', to: 'stock_signals#compact', as: 'stock_signals_compact'
  resources :stocks
  root to: 'stock_signals#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
