Backplane::Application.routes.draw do
  namespace :engage do
    resource :token, only: :create
  end

  root 'top#show'
end
