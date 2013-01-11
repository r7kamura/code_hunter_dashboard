CodeHunterDashboard::Application.routes.draw do
  resources :reports, only: :create
end
