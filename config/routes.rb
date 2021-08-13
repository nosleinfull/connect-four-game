Rails.application.routes.draw do
  resources :game, only: %i[show update] do
    resources :board, only: [:index]
    resources :player_moves, only: [:create]
  end
end
