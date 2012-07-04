Deployd::Engine.routes.draw do
  resources :deploys do
    collection do
      get 'predict'
    end
  end
  root :to => "deploys#index"
end
