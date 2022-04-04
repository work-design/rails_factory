Rails.application.routes.draw do

  concern :productive do
    resources :productions, only: [:index, :show] do
      collection do
        post :scene
        post :produce_on
      end
      resources :product_plans, only: [:index, :show]
    end
  end

  namespace :factory, defaults: { business: 'factory' } do
    concerns :productive
    resources :providers, only: [] do
      collection do
        get :search
      end
    end
    resources :products, only: [:index, :show]
    resources :product_taxons, only: [:index, :show]
    resources :produce_plans, only: [:index, :show]

    namespace :buy, defaults: { namespace: 'buy' } do
      controller :home do
        get :index
      end
      concerns :productive
      resources :productions do
        collection do
          post :list
        end
      end
      resources :factory_taxons, only: [:index, :show]
      resources :produce_plans, only: [:index]
      resources :carts do
        collection do
          get :list
          post :actions
        end
      end
      resources :payments do
        member do
          get :wxpay_pc_pay
        end
      end
    end

    namespace :admin, defaults: { namespace: 'admin' } do
      root 'home#index'
      scope :produce_on, controller: :produce_on do
        get :index
      end
      resources :product_taxons do
        member do
          patch :reorder
        end
      end
      resources :plans
      resources :scenes do
        member do
          patch :actions
        end
        resources :produce_plans do
          member do
            get :products
            patch :actions
          end
        end
        resources :scene_automatics
      end
      resources :products do
        collection do
          get :add_item
          get :remove_item
        end
        member do
          patch :actions
        end
        resources :product_part_taxons do
          member do
            get :part
          end
          resources :product_parts
        end
        resources :productions do
          member do
            get :part
            get :price
            get :vip
            patch :update_vip
            patch :provide
            patch :actions
          end
        end
      end
      resources :productions, only: [] do
        resources :addresses
        resources :trade_items do
          member do
            patch :print
          end
        end
        resources :provideds
        resources :production_plans do
          member do
            patch :actions
          end
          resources :production_items do
            collection do
              post :batch
            end
            member do
              patch :actions
              patch :print
            end
          end
        end
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
            post :search
          end
        end
      end
      resources :scenes
    end
  end

end
