module Factory
  class My::ProvidersController < My::BaseController
    before_action :set_provider, only: [:show, :edit, :update]

    def show
    end

    def edit
    end

    def update
      @provider.assign_attributes(provider_params)

      Provider.transaction do
        current_buyer.save! if @provider.new_record?
        @provider.save!
      end

      if @provider.saved_changes?
        @provider.logo.attach(logo_params) if logo_params.present?
        redirect_to(my_provider_url, notice: 'Provider 更新成功。')
      else
        render action: 'edit'
      end
    end

    private
    def set_provider
      @provider = current_user.provider || current_user.build_provider
    end

    def provider_params
      params.fetch(:provider, {}).permit(:name)
    end

    def logo_params
      params.fetch(:provider, {}).permit(:logo).fetch(:logo, {})
    end

  end
end
