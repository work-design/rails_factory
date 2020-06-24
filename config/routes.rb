Rails.application.routes.draw do

  scope module: 'factory' do
    resources :providers, only: [] do
      collection do
        get :search
      end
    end
    resources :products do
      resources :customs, shallow: true
      resources :product_plans, only: [:index, :show]
    end
    resources :product_taxons
  end

  scope :admin, module: 'factory/admin', as: :admin do
    resources :product_taxons
    resources :produce_plans
    resources :products do
      resources :product_plans, as: 'plans'
      resources :product_items, as: 'items'
    end
    resources :customs do
      resources :addresses
      resources :trade_items
    end
    resources :providers
    resources :part_taxons
    resources :parts do
      resources :part_plans, as: 'plans'
      resources :part_items, as: 'items'
    end
    scope ':good_type/:good_id' do
      resources :good_providers do
        member do
          patch :select
        end
      end
    end
  end

  scope :my, module: 'factory/my', as: :my do
    resource :provider
    resources :products
    resources :customs do
      collection do
        post :price
      end
      member do
        post :cart
      end
      resources :trade_items
    end
    resources :facilitates, only: [] do
      member do
        put :order
      end
    end
    resources :good_providers
  end

end
