Rails.application.routes.draw do

  scope :admin, module: 'pms_admin', as: 'admin' do
    root to: 'home#index'

    resources :products do
      resources :product_plans, as: 'plans'
      resources :product_items, as: 'items'
    end
    resources :parts do
      resources :part_plans, as: 'plans'
      resources :part_items, as: 'items'
    end

  end

end
