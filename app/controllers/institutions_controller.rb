class InstitutionsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
  end

  def live_search
    @institutions = Institution.order('name')
    if !params[:q].blank?
      @institutions = @institutions.where("(CONCAT(name,' ',short_name) LIKE :n OR id LIKE :n)", {:n => "%#{params[:q]}%"}) 
    end

    render :layout => false
  end

  def show
    @institution = Institution.find(params[:id])
    @countries = Country.order('name')
    @states = State.order('code')
    render :layout => false
  end

  def new
    @institution = Institution.new
    render :layout => false
  end

  def create
    @institution = Institution.new(params[:institution])

    if @institution.save
      flash[:notice] = "Institucion creada."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @institution.id
            render :json => json
          else 
            redirect_to @institution
          end
        end
      end
    else
      flash[:error] = "Error al crear institucion."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @institution.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @institution
          end
        end
      end
    end
  end

  def update 
    @institution = Institution.find(params[:id])

    if @institution.update_attributes(params[:institution])
      flash[:notice] = "Institucion actualizada."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @institution
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la institucion."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @institution.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @institution
          end
        end
      end
    end
  end

  def change_image
    @institution = Institution.find(params[:id])
    render :layout => 'standalone'
  end

  def upload_image
    @institution = Institution.find(params[:id])
    if @institution.update_attributes(params[:institution])
      flash[:notice] = "Imagen actualizada."
    else
      flash[:error] = "Error al actualizar la imagen."
    end

    redirect_to :action => 'change_image', :id => params[:id]
  end

end
