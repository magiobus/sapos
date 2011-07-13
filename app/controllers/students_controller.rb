class StudentsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
    @programs = Program.order('name')
  end

  def live_search
    @students = Student.order("first_name").includes(:program)

    if params[:program] != '0' then
      @students = @students.where(:program_id => params[:program])
    end 

    if !params[:q].blank?
      @students = @students.where("(CONCAT(first_name,' ',last_name) LIKE :n OR card LIKE :n)", {:n => "%#{params[:q]}%"}) 
    end

    s = []

    if !params[:status_activos].blank?
      s << params[:status_activos].to_i
    end

    if !params[:status_egresados].blank?
      s << params[:status_egresados].to_i
    end

    if !params[:status_bajas].blank?
      s << params[:status_bajas].to_i
    end

    if !s.empty?
      @students = @students.where("status IN (#{s.join(',')})")
    end

    render :layout => false
  end

  def show
    @student = Student.includes(:program, :thesis, :contact, :scholarship, :advance).find(params[:id])
    @staffs = Staff.order('first_name').includes(:institution)
    @countries = Country.order('name')
    @institutions = Institution.order('name')
    @states = State.order('code')
    render :layout => false
    #render :inline => "Debugging"
  end

  def new
    @student = Student.new
    @programs = Program.order('name')
    render :layout => false
  end

  def create
    @student = Student.new(params[:student])

    if @student.save
      flash[:notice] = "Estudiante creado."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @student.card
            render :json => json
          else 
            redirect_to @student
          end
        end
      end
    else
      flash[:error] = "Error al crear estudiante."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @student.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @student
          end
        end
      end
    end
  end

  def update 
    @student = Student.find(params[:id])

    if @student.update_attributes(params[:student])
      flash[:notice] = "Estudiante actualizado."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @student
          end
        end
      end
    else
      flash[:error] = "Error al actualizar al estudiante."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @student.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @student
          end
        end
      end
    end
  end

  def change_image
    @student = Student.find(params[:id])
    render :layout => 'standalone'
  end

  def upload_image
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Imagen actualizada."
    else
      flash[:error] = "Error al actualizar la imagen."
    end

    redirect_to :action => 'change_image', :id => params[:id]
  end

  def files
    @student = Student.includes(:student_file).find(params[:id])
    @student_file = StudentFile.new
    render :layout => 'standalone'
  end

  def upload_file
    params[:student_file]['file'].each do |f|
      @student_file = StudentFile.new(f)
      @student_file.student_id = params[:student_file]['student_id']
      @student_file.file = f
      @student_file.description = f.original_filename
      if @student_file.save
        flash[:notice] = "Archivo subido exitosamente."
      else
        flash[:error] = "Error al subir archivo."
      end
    end

    redirect_to :action => 'files', :id => params[:id]
  end

  def file
    s = Student.find(params[:id])
    sf = s.student_file.find(params[:file_id]).file
    send_file sf.to_s, :x_sendfile=>true
  end 

  def delete_file
  end

  def new_advance
    @student = Student.find(params[:id])
    @staffs = Staff.order('first_name')
    render :layout => 'standalone'
  end

  def create_advance
    @student = Student.find(params[:student_id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Nuevo avance creado."
    else
      flash[:error] = "Error al crear avance."
    end
    render :layout => 'standalone'
  end

end
