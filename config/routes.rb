CodeHunterDashboard::Application.routes.draw do
  root :to => "reports#dashboard"

  resources :reports, :only => [:index, :show, :create] do
    collection do
      get :dashboard
      get :latest
    end
  end

  resources :warnings, :only => :show
end
