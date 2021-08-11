Rails.application.routes.draw do
  resources :game, only: [:show] do
    resources :board, only: [:index]
    resources :player_moves, only: [:create]
  end
end
