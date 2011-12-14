class ScholarshipCategoriesController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json
  
  def index
  end
  
  def live_search
    @scholarship_categories = ScholarshipCategory.order('name')
    if !params[:q].blank?
      @scholarship_categories = @scholarship_categories.where("(name LIKE :n)", {:n => "%#{params[:q]}%"}) 
    end
      render :layout => false
    end
    
    def show
      @scholarship_category = ScholarshipCategory.find(params[:id])
      render :layout => false
    end
    
    def new
      @scholarship_category = ScholarshipCategory.new
      render :layout => false
    end

    def create
      @scholarship_category = ScholarshipCategory.new(params[:scholarship_category])

      if @scholarship_category.save
        flash[:notice] = "Categoria creada."

        respond_with do |format|
          format.html do
            if request.xhr?
              json = {}
              json[:flash] = flash
              json[:uniq] = @scholarship_category.name
              render :json => json
            else 
              redirect_to @scholarship_category
            end
          end
        end
      else
        flash[:error] = "Error al crear aula."
        respond_with do |format|
          format.html do
            if request.xhr?
              json = {}
              json[:flash] = flash
              json[:errors] = @scholarship_category.errors
              render :json => json, :status => :unprocessable_entity
            else
              redirect_to @scholarship_category
            end
          end
        end
      end
    end

    def update 
      @scholarship_category = ScholarshipCategory.find(params[:id])

      if @scholarship_category.update_attributes(params[:scholarship_category])
        flash[:notice] = "Categoria actualizada."
        respond_with do |format|
          format.html do
            if request.xhr?
              json = {}
              json[:flash] = flash
              render :json => json
            else 
              redirect_to @scholarship_category
            end
          end
        end
      else
        flash[:error] = "Error al actualizar categoria."
        respond_with do |format|
          format.html do
            if request.xhr?
              json = {}
              json[:flash] = flash
              json[:errors] = @scholarship_category.errors
              render :json => json, :status => :unprocessable_entity
            else 
              redirect_to @scholarship_category
            end
          end
        end
      end
    end
    
    def new_type
      @scholarship_category = ScholarshipCategory.find(params[:id])
      render :layout => 'standalone'
    end
    
    def create_type
      @scholarship_category = ScholarshipCategory.find(params[:scholarship_category_id])
      if @scholarship_category.update_attributes(params[:scholarship_category])
        flash[:notice] = "Nuevo tipo creado."
      else
        flash[:error] = "Error al crear tipo."
      end
      render :layout => 'standalone'
    end
    
    def edit_type
      @scholarship_category = ScholarshipCategory.find(params[:id])
      @type = ScholarshipType.find(params[:scholarship_type_id])
      render :layout => false
    end
    
    def types_table
        @scholarship_category = ScholarshipCategory.find(params[:id])
        render :layout => false
    end
    
    
end
