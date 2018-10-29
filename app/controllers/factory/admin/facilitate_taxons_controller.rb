class Waiting::Admin::FacilitateTaxonsController < Waiting::Admin::BaseController
  before_action :set_facilitate_taxon, only: [:edit, :update, :destroy]

  def new
    @facilitate_taxon = FacilitateTaxon.new
  end

  def edit
  end

  def create
    @facilitate_taxon = FacilitateTaxon.new(facilitate_taxon_params)

    if @facilitate_taxon.save
      redirect_to params[:return_to], notice: 'Section taxon 创建成功。'
    else
      render action: 'new'
    end
  end

  def update
    if @facilitate_taxon.update(facilitate_taxon_params)
      redirect_to admin_facilitates_url, notice: 'Section taxon 更新成功。'
    else
      render action: 'edit'
    end
  end

  def destroy
    @facilitate_taxon.destroy
    redirect_to facilitate_taxons_path, notice: '删除成功!'
  end

  private
  def set_facilitate_taxon
    @facilitate_taxon = FacilitateTaxon.find(params[:id])
  end

  def facilitate_taxon_params
    params.fetch(:facilitate_taxon, {}).permit(:name)
  end

end
