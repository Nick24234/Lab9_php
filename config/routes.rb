Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :users
      resources :transfers
    end
  end

  scope '(:locale)', locale: /uk|en/ do
    devise_for :users
    get 'static_pages/landing_page'
    get 'static_pages/dashboard'
    root 'static_pages#landing_page'
    # Статичні сторінки
    get 'about', to: 'pages#about'
    get 'support', to: 'pages#support'
    post 'support', to: 'pages#support_result'
    
    resources :users do
      collection do
        get 'registration_params', to: 'users#registration_params'
      end
    end
    
    resources :transfers do
      member do
        patch :complete
        patch :cancel
      end
    end
  end
end
