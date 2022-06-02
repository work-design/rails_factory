Rails.application.routes.draw do

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
        member do
          patch :actions
        end
        resources :product_part_taxons do
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
        resources :fits
      end
      resources :provides do
        collection do
          post :search
        end
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
              get :print_data
            end
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
        resources :trade_items, only: [:index]
      end
      resources :trade_items, only: [:create, :update, :destroy]
    end

    namespace :panel, defaults: { namespace: 'panel' } do
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

  resolve 'Factory::Production' do |production, options|
    [:factory, production, options]
  end

end
