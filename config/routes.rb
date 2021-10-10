Rails.application.routes.draw do
  scope 'my' do
    devise_for :users, path: "", :controllers => {
     :registrations => 'users/registrations',
     :sessions => 'users/sessions'
    }
  end
  devise_scope :user do
    get 'user/:name' => 'users/registrations#show', as: :user
    get 'my' => 'users/registrations#my'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get '/search' => 'homes#search'
  get '/info' => 'homes#info'
  scope 'info' do
    resource :coments, only:[:show,:create]
  end

  resources :game, except:[:destroy], param: :name do
    resource :game_coments, only:[:show,:create]
    resource :coments, only:[:show,:create]
    resource :reviews, only:[:show,:new,:create]
    resource :game_favorites, only: [:create,:destroy]
  end
  resource :genres, only:[:show,:create,:update] do
    resource :coments, only:[:show,:create]
  end
  resource :machines, only:[:show,:create,:update] do
    resource :coments, only:[:show,:create]
  end
  resource :tags, only:[:show]

  #resources :users, only:[:show,:edit,:update]

  get '/admin'        => 'admins#top'
  get '/admin/search' => 'admins#search'
  resource :admins, only:[:edit,:update,:destroy]
end
