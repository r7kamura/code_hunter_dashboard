CodeHunterDashboard::Application.routes.draw do
  root :to => "reports#dashboard"

  resources :reports, :only => [:index, :show, :create] do
    collection do
      get :dashboard
      get :latest
    end

    resources :warnings, :only => [] do
      collection do
        get ":author" => :author, :as => :author
      end
    end
  end

  resources :warnings, :only => :show
end
