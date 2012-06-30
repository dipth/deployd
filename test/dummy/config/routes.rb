Rails.application.routes.draw do

  mount Deployd::Engine => "/deployd"
end
