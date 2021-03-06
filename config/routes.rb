Rails.application.routes.draw do
  root to: 'blogs#index'

  devise_for :users,
  :controllers => {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :blogs do
    resources :comments
  end

  get 'coach_lp' => 'blogs#coach_lp'
  get 'myself_lp' => 'blogs#myself_lp'

  resources :tags do
    get 'blogs', to: 'blogs#search'
  end
end
