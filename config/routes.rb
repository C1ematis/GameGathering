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
  post '/search' => 'homes#search'
  get '/info' => 'homes#info'
  scope 'info' do
    resources :coments, only:[:index,:create]
  end
  get '/autocomplete_games/:word' => 'games#autocomplete_games'
  get '/autocomplete_tags/:tags' => 'tags#autocomplete_tags'

  resources :games, except:[:edit, :destroy], param: :name do
    resources :game_coments, only:[:index,:create]
    resources :coments, only:[:index,:create]
    resources :reviews, only:[:index,:new,:create]
    resource :game_favorites, only: [:create,:destroy]
  end
  resources :genres, only:[:index,:create,:update] do
    resources :coments, only:[:index,:create]
  end
  resources :machines, only:[:index,:create,:update] do
    resources :coments, only:[:index,:create]
  end
  resources :tags, only:[:index, :create, :destroy]

  #resources :users, only:[:show,:edit,:update]

  get '/admin'        => 'admins#top'
  get '/admin/search' => 'admins#search'
  resource :admins, only:[:edit,:update,:destroy]
end
