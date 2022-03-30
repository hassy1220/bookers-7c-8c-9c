Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get '/search', to: 'searches#searche'
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource:favorites,only:[:create, :destroy]
    resources:book_comments,only:[:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource:relationship,only:[:create, :destroy]
    get "relationships/follow_list"
    get "relationships/follower_list"
  end
  # get '/search'=>'searches#search',as:"search"
  # get '/search', to: 'searchs#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

