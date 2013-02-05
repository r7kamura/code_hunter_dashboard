CodeHunterDashboard::Application.routes.draw do
  root :to => "reports#top"

  get "/login" => redirect("/auth/github"), :as => :login

  resources :reports, :only => [:index, :show, :create] do
    collection do
      get :stats
      get :latest
      get :top
    end

    resources :warnings, :only => [] do
      collection do
        get ":author" => :author, :as => :author
      end
    end
  end

  resources :warnings, :only => :show

  resource :user, :only => :show

  controller :sessions do
    get "auth/:provider/callback" => :create
    get "auth/failure"            => :failure
    delete "logout"               => :destroy
  end
end
