CodeHunterDashboard::Application.routes.draw do
  resources :warnings, only: :create
end
