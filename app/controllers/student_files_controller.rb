class StudentFilesController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json
  def destroy
    @student_file = StudentFile.find(params[:id])
    if @student_file.destroy
      flash[:notice] = "Archivo eliminado"

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else
            redirect_to @student_file
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
            redirect_to @student_file
          end
        end
      end
    end

  end

  def update
    @student_file = StudentFile.find(params[:id])

    if @student_file.update_attributes(params[:student_file])
      flash[:notice] = "Descripci?n actualizada."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:id] = params[:id]
            json[:newdesc] = params[:student_file][:description]
            render :json => json
          else
            redirect_to @student_file
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
            json[:newdesc] = params[:student_file][:description]
            json[:errors] = @student_file.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @student_file
          end
        end
      end
    end
  end

end
