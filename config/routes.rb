Rails.application.routes.draw do

  scope module: 'factory' do
    resources :providers, only: [] do
      get :search, on: :collection
    end
    resources :products, shallow: true do
      resources :customs
    end
  end

  scope :admin, module: 'factory/admin', as: 'admin' do
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

    scope ':good_type/:good_id' do
      resources :good_providers do
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
    resources :good_providers
  end

  scope :wx, module: 'factory/wx', as: :wx do
  end

end
