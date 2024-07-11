module Factory
  class Admin::HomeController < Admin::BaseController

    def index
      @taxon_count = ProductTaxon.default_where(default_params).count
      @scene_count = Scene.default_where(default_params).count
    end

  end
end
