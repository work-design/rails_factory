Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    concern :productive do
      resources :productions, only: [:index, :create, :show] do
        collection do
          get :nav
          get :rent
          get :members
          post :scene
          post :produce_on
          post :change_dispatch
        end
        member do
          post :list
          patch :create_dialog
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
        root 'home#index'
        resources :provides
        resources :product_taxons, only: [:index, :show] do
          member do
            post :productions
          end
        end
        resources :items do
          member do
            post :edit_assign
            patch :update_assign
          end
        end
        resources :payments do
          member do
            get :wxpay_pc_pay
          end
        end
      end

      namespace :mem, defaults: { namespace: 'mem' } do
        concerns :productive
      end

      namespace :my, defaults: { namespace: 'my' } do
        concerns :productive
      end

      namespace :our, defaults: { namespace: 'our' } do
        concerns :productive
      end

      namespace :agent, defaults: { namespace: 'agent' } do
        concerns :productive
      end

      namespace :admin, defaults: { namespace: 'admin' } do
        root 'home#index'
        scope :produce_on, controller: :produce_on do
          get :index
        end
        resource :organ
        resources :brands
        resources :product_taxons do
          collection do
            get :all
          end
          member do
            patch :reorder
            get :import
            post :copy
            delete :prune
          end
          resources :products, controller: 'taxon/products' do
            collection do
              get :buy
              get :publish
            end
            member do
              patch :move_lower
              patch :move_higher
              patch :reorder
            end
          end
          resources :provides, controller: 'taxon/provides' do
            collection do
              post :search
            end
          end
          resources :product_part_taxons, controller: 'taxon/product_part_taxons'
        end
        resources :provides do
          collection do
            post :search
          end
        end
        resources :products do
          collection do
            get :buy
          end
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
          resources :product_part_taxons
          resources :productions do
            member do
              match :part, via: [:get, :post]
              match :price, via: [:get, :post]
              match :cost, via: [:get, :post]
              match :card, via: [:get, :post]
              patch :update_card
              match :wallet, via: [:get, :post]
              patch :update_wallet
              patch :provide
            end
          end
          resources :fits
        end
        resources :product_part_taxons, only: [] do
          resources :product_parts
        end
        resources :productions, only: [] do
          collection do
            get :all
            get 'taxon/:product_taxon_id' => :taxon
          end
          resources :addresses
          resources :trade_items do
            member do
              patch :print
            end
          end
          resources :purchase_items do
            collection do
              post :batch_receive
            end
          end
          resources :stock_logs
          resources :part_providers do
            collection do
              post :search
            end
          end
          resources :production_plans do
            resources :production_plan_items, path: 'items', only: [:index, :create, :show, :edit, :destroy] do
              collection do
                post :batch
              end
              member do
                patch :print
              end
            end
          end
          resources :production_items do
            collection do
              post :batch
              get 'delivery/:item_id' => :delivery
            end
            member do
              patch 'delivery/:item_id' => :update_delivery
              patch :print
              get :pdf
              get :print_data
            end
          end
          resources :rent_charges do
            member do
              get :wallet
              patch 'wallet' => :update_wallet
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
  resolve 'Factory::Production' do |production|
    url_for(controller: '/factory/productions', action: 'show', id: production, return_state: StateUtil.encode(request))
  end
  resolve 'Factory::ProxyProduction' do |production|
    url_for(controller: '/factory/productions', action: 'show', id: production, return_state: StateUtil.encode(request))
  end

end
