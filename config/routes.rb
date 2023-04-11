Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    concern :productive do
      resources :productions, only: [:index, :create, :show] do
        collection do
          get :members
          post :scene
          post :produce_on
          post :create_dialog
        end
        member do
          post :list
          put :dialog
        end
        resources :product_plans, only: [:index, :show]
      end
      resources :produce_plans, only: [:index] do
        collection do
          get :overview
          post :actions
        end
      end
      resources :scenes
      resources :carts do
        collection do
          get :list
          post :actions
        end
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

      namespace :in, defaults: { namespace: 'in' } do
        concerns :productive
        resources :product_taxons, only: [:index, :show] do
          member do
            get :import
            post :productions
            post :copy
            delete :prune
          end
          resources :provides do
            collection do
              post :search
              post :add
            end
          end
        end
        resources :items
        resources :payments do
          member do
            get :wxpay_pc_pay
          end
        end
      end

      namespace :mem, defaults: { namespace: 'mem' } do
        concerns :productive
      end

      namespace :our, defaults: { namespace: 'our' } do
        concerns :productive
      end

      namespace :admin, defaults: { namespace: 'admin' } do
        root 'home#index'
        scope :produce_on, controller: :produce_on do
          get :index
        end
        resources :brands
        resources :product_taxons do
          member do
            patch :reorder
          end
          resources :products
        end
        resources :plans
        resources :scenes do
          resources :produce_plans do
            member do
              get :products
            end
          end
          resources :scene_automatics
        end
        resources :products, only: [] do
          resources :product_part_taxons do
            resources :product_parts
          end
          resources :productions do
            member do
              get :part
              get :price
              get :cost
              get :card
              patch :update_card
              patch :provide
            end
          end
          resources :fits
        end
        resources :productions, only: [] do
          resources :addresses
          resources :trade_items do
            member do
              patch :print
            end
          end
          resources :part_providers do
            collection do
              post :search
            end
          end
          resources :production_plans
          resources :production_items do
            collection do
              post :batch
            end
            member do
              patch :print
              get :pdf
              get :print_data
            end
          end
        end
      end

      namespace :me, defaults: { namespace: 'me' } do
        resources :production_items do
          member do
            post :in
            post :out
            get :qrcode
          end
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
          resources :items, only: [:index]
        end
        resources :items, only: [:create, :update, :destroy]
      end

      namespace :panel, defaults: { namespace: 'panel' } do
        root 'home#index'
        resources :factory_taxons do
          resources :factory_providers do
            collection do
              post :search
            end
          end
        end
        resources :scenes
        resources :brands do
          resources :serials
        end
        resources :unifiers
      end
    end
  end
  resolve 'Factory::Production', controller: 'productions' do |production, options|
    route_for(:factory_production, production, options)
  end

end
