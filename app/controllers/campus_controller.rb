# coding: utf-8
class CampusController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
  end

  def live_search
    @campus = Campus.order('name')
    if !params[:q].blank?
      @campus = @campus.where("(CONCAT(name,' ',short_name) LIKE :n OR id LIKE :n)", {:n => "%#{params[:q]}%"}) 
    end

    render :layout => false
  end

  def show
    @campus = Campus.find(params[:id])
    @countries = Country.order('name')
    @states = State.order('code')
    render :layout => false
  end

  def new
    @campus = Campus.new
    render :layout => false
  end

  def create
    @campus = Campus.new(params[:campus])

    if @campus.save
      flash[:notice] = "Campus creada."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @campus.id
            render :json => json
          else 
            redirect_to @campus
          end
        end
      end
    else
      flash[:error] = "Error al crear campus."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @campus.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @campus
          end
        end
      end
    end
  end

  def update 
    @campus = Campus.find(params[:id])

    if @campus.update_attributes(params[:campus])
      flash[:notice] = "Campus actualizado."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @campus
          end
        end
      end
    else
      flash[:error] = "Error al actualizar el campus."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @campus.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @campus
          end
        end
      end
    end
  end

  def change_image
    @campus = Campus.find(params[:id])
    render :layout => 'standalone'
  end

  def upload_image
    @campus = Campus.find(params[:id])
    if @campus.update_attributes(params[:campus])
      flash[:notice] = "Imagen actualizada."
    else
      flash[:error] = "Error al actualizar la imagen."
    end

    redirect_to :action => 'change_image', :id => params[:id]
  end

end
