Rails.application.routes.draw do
  scope RailsCom.default_routes_scope do
    concern :productive do
      resources :productions, only: [:index, :create, :show] do
        collection do
          post :scene
          post :produce_on
          post :create_dialog
        end
        member do
          put :dialog
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

      namespace :in, defaults: { namespace: 'in' } do
        root 'home#index'
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
        resources :orders
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
        resources :brands
        resources :product_taxons do
          member do
            patch :reorder
            get :import
            get :productions
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
        resources :products do
          resources :product_part_taxons do
            resources :product_parts
          end
          resources :productions do
            member do
              get :part
              get :price
              get :card
              patch :update_card
              patch :provide
            end
          end
          resources :fits
        end
        resources :provides do
          collection do
            post :search
          end
        end
        resources :productions, only: [] do
          resources :addresses
          resources :items do
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
        resources :factory_taxons
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
  resolve 'Factory::Production' do |production, options|
    [:factory, production, options]
  end

end
