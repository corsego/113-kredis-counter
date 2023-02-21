Rails.application.routes.draw do
  post 'increment', to: 'counter#increment'
  post 'decrement', to: 'counter#decrement'
  root "counter#show"
end
