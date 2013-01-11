CodeHunterDashboard::Application.routes.draw do
  root :to => "reports#latest"

  resources :reports, :only => [:index, :show, :create] do
    collection do
      get :latest
    end
  end
end
