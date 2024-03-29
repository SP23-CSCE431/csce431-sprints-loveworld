Rails.application.routes.draw do
  resources :event_members
  resources :group_members
  resources :events
  resources :groups
  resources :users
  resources :posts do
    resources :comments
  end
  resources :replies

  resources :forum_posts


  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'dashboards#show', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
end

