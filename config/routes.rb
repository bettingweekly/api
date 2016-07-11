Rails.application.routes.draw do
  namespace :api, path: '/' do
    namespace :v1 do
      scope '/fizz_buzz' do
        resources :fizz_buzzs, only: :index, path: '/'
        resources :favourites, only: [:index, :create]
      end
    end
  end
end
