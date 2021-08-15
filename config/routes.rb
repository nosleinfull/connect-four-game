Rails.application.routes.draw do
  root to: 'game#index'
  resources :game, only: %i[show update index] do
    resources :board, only: [:index]
    resources :player_moves, only: [:create]
  end
end
