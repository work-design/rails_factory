Rails.application.routes.draw do

  scope module: 'factory' do
    resources :facilitates, only: [:index, :show]
    resources :providers, only: [] do
      get :search, on: :collection
    end
  end

  scope :admin, module: 'factory/admin', as: 'admin' do
    root to: 'home#index'

    resources :products do
      resources :product_plans, as: 'plans'
      resources :product_items, as: 'items'
    end
    resources :providers
    resources :customs
    resources :part_taxons
    resources :parts do
      resources :part_plans, as: 'plans'
      resources :part_items, as: 'items'
    end
    resources :facilitate_taxons, except: [:index, :show]
    resources :facilitates do
      resources :good_providers, shallow: true do
        patch :verify, on: :member
        patch :select, on: :member
      end
    end
  end

  scope :my, module: 'factory/my', as: :my do
    resource :provider
    resources :customs
    resources :facilitates, only: [] do
      put :order, on: :member
    end
    resources :facilitate_providers
  end

  scope :wx, module: 'waiting/wx', as: :wx do
    resources :facilitates
  end

end
