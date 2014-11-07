RailsResqueDemo::Application.routes.draw do
  # resque server
  mount Resque::Server, :at => '/resque'

  get '/test', to: 'test#index'
end
