Rails.application.routes.draw do

  namespace 'factory', defaults: { business: 'factory' } do
    resources :providers, only: [] do
      collection do
        get :search
      end
    end
    resources :products do
      resources :product_plans, only: [:index, :show]
    end
    resources :product_taxons
    resources :produce_plans

    namespace :admin, defaults: { namespace: 'admin' } do
      resources :product_taxons do
        member do
          patch :reorder
        end
      end
      resources :produce_plans
      resources :products do
        collection do
          get :add_item
          get :remove_item
        end
        member do
          get :part
        end
        resources :product_plans, as: 'plans'
        resources :product_items, as: 'items'
        resources :product_part_taxons, as: 'part_taxons', path: 'part_taxons'
        resources :product_parts, as: 'parts', path: 'parts'
        resources :productions do
          member do
            get :part
            get :price
            patch :provide
          end
        end
      end
      resources :productions, only: [] do
        resources :addresses
        resources :trade_items
        resources :provideds
      end
      resources :part_taxons do
        member do
          get :import
          get :productions
        end
      end
      resources :factory_taxons
      resources :parts do
        resources :part_plans, as: 'plans'
        resources :part_items, as: 'items'
        resources :part_providers, as: 'providers'
      end
    end

    namespace :my, defaults: { namespace: 'my' } do
      resource :provider
      resources :products
      resources :productions do
        collection do
          post :price
        end
        member do
          post :cart
        end
        resources :trade_items
      end
    end

    namespace :panel, defaults: { namespace: 'panel' } do
      resources :factory_taxons do
        resources :providers do
          collection do
            get :search
          end
        end
      end
    end
  end

end
