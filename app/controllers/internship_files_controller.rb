# coding: utf-8
class InternshipFilesController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json
  def destroy
    @internship_file = InternshipFile.find(params[:id])
    if @internship_file.destroy
      flash[:notice] = "Archivo eliminado"

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else
            redirect_to @internship_file
          end
        end
      end
    else
      flash[:error] = "Error al eliminar archivo"
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @internship_file
          end
        end
      end
    end

  end

  def update
    @internship_file = InternshipFile.find(params[:id])

    if @internship_file.update_attributes(params[:internship_file])
      flash[:notice] = "Descripci?n actualizada."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:id] = params[:id]
            json[:newdesc] = params[:internship_file][:description]
            render :json => json
          else
            redirect_to @internship_file
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la descripcion."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:id] = params[:id]
            json[:newdesc] = params[:internship_file][:description]
            json[:errors] = @internship_file.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @internship_file
          end
        end
      end
    end
  end

end
