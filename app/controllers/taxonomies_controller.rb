class TaxonomiesController < ApplicationController
  before_action :set_taxonomy, only: [:show, :edit, :update, :destroy]
  before_action :set_taxonomy_types, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :authenticate_user!    
  helper_method :sort_column, :sort_direction    

  def index
    if params[:search_by_text].present?
      search_by_text = params[:search_by_text]
    elsif params[:term].present?
      search_by_text = params[:term]
    end

    @taxonomies = Taxonomy.search(search_by_text,
                                  params[:search_by_type],
                                  sort_column,
                                  sort_direction
                                 )
    flash[:notice] = @taxonomies.length == 0 ? 'Nenhuma TAG encontrada.' : @taxonomies.length.to_s+' TAGs encontradas.' 
    @taxonomies = @taxonomies.paginate(:page => params[:page], :per_page => 20) 
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @taxonomies.map(&:code) }    
    end
  end

  def show
  end

  def new
    @taxonomy = Taxonomy.new
  end

  def edit
  end

  def create
    @taxonomy = Taxonomy.new(taxonomy_params)
    @taxonomy.user_id = current_user.id 
    respond_to do |format|
      if @taxonomy.save
        format.html { redirect_to @taxonomy, notice: @taxonomy.code+t(:was_created) }
        format.json { render :show, status: :created, location: @taxonomy }
      else
        format.html { render :new }
        format.json { render json: @taxonomy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @taxonomy.update(taxonomy_params)
        format.html { redirect_to @taxonomy, notice: @taxonomy.code+t(:was_updated) }
        format.json { render :show, status: :ok, location: @taxonomy }
      else
        format.html { render :edit }
        format.json { render json: @taxonomy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @taxonomy.destroy
    respond_to do |format|
      format.html { redirect_to taxonomies_url, notice: @taxonomy.code+t(:was_destroyed) }
      format.json { head :no_content }
    end
  end

  private
    def set_taxonomy
      @taxonomy = Taxonomy.find(params[:id])
    end

    def set_taxonomy_types
      @TAXONOMY_TYPES = ['Comum','Tela','Macro']      
    end

    def taxonomy_params
      params.require(:taxonomy).permit(:code, :description, :kind, :correlation)
    end

    def sort_column
      params[:sort] || "code"
    end

    def sort_direction
      params[:direction] || "desc"
    end    

end
