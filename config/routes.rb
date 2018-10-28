Rails.application.routes.draw do

  scope :admin, module: 'factory/admin', as: 'admin' do
    root to: 'home#index'

    resources :products do
      resources :product_plans, as: 'plans'
      resources :product_items, as: 'items'
    end
    resources :customs
    resources :part_taxons
    resources :parts do
      resources :part_plans, as: 'plans'
      resources :part_items, as: 'items'
    end

  end

  scope :my, module: 'factory/my', as: :my do
    resources :customs
  end

end
