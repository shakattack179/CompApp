Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'competitions#new'
  resources :competitions
  post 'prepare_draw', to: 'competitions#prepare_draw'
  get 'perform_draw', to: 'competitions#perform_draw'
end
