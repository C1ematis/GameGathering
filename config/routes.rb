Rails.application.routes.draw do
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
   :sessions => 'users/sessions'
  }
  devise_scope :user do
    get 'users' => 'users/registrations#show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get '/info' => 'homes#info'
  scope 'info' do
    resource :coments, only:[:show,:create]
  end

  resources :game, except:[:destroy] do
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
