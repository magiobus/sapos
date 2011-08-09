# coding: utf-8
class ProgramsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
  end

  def live_search
    @programs = Program.order('name')
    if !params[:q].blank?
      @programs = @programs.where("name LIKE :n OR prefix LIKE :n", {:n => "%#{params[:q]}%"}) 
    end

    render :layout => false
  end

  def show
    @program = Program.find(params[:id])
    render :layout => false
  end

  def new
    @program = Program.new
    render :layout => false
  end

  def create
    @program = Program.new(params[:program])

    if @program.save
      flash[:notice] = "Programa creada."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @program.prefix
            render :json => json
          else 
            redirect_to @program
          end
        end
      end
    else
      flash[:error] = "Error al crear programa."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @program.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @program
          end
        end
      end
    end
  end

  def update 
    @program = Program.find(params[:id])
    if @program.update_attributes(params[:program])
      flash[:notice] = "Programa actualizada."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @program
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la programa."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @program.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @program
          end
        end
      end
    end
  end

  def plan_table
    @program = Program.find(params[:id])
    render :layout => false
  end

  def new_course
    @program = Program.find(params[:id])
    render :layout => 'standalone'
  end

  def create_course
    @program = Program.find(params[:program_id])
    if @program.update_attributes(params[:program])
      flash[:notice] = "Nuevo curso creado."
    else
      flash[:error] = "Error al crear curso."
    end
    render :layout => 'standalone'
  end

  def edit_course
    @program = Program.find(params[:id])
    @course = Course.find(params[:course_id])
    render :layout => false
  end

  def new_term
    @program = Program.find(params[:id])
    render :layout => 'standalone'
  end

  def create_term
    @program = Program.find(params[:program_id])
    if @program.update_attributes(params[:program])
      flash[:notice] = "Nuevo curso creado."
    else
      flash[:error] = "Error al crear curso."
    end
    render :layout => 'standalone'
  end

  def edit_term
    @program = Program.find(params[:id])
    @term = Term.find(params[:term_id])
    render :layout => false
  end

  def terms_table
    @program = Program.find(params[:id])
    render :layout => false
  end

  def terms_dropdown
    render :layout => false
  end

  def courses_dropdown
    @term_course = TermCourse.where('term_id = :t', {:t => params[:term_id]})
    @term = Term.find(params[:term_id])
    render :layout => false
  end

 
  def enrollment_table
    @term = Term.find(params[:term_id])
    render :layout => false
  end

  def new_enrollment
    @program = Program.find(params[:id])
    @term = Term.find(params[:term_id])
    render :layout => 'standalone'
  end

  def create_enrollment
    @term = Term.find(params[:term_id])
    if @term.update_attributes(params[:term])
      flash[:notice] = "Estudiante inscrito satisfactoriamente"
    else
      flash[:error] = "Error al inscribir estudiante."
    end
    render :layout => 'standalone'
  end

  def edit_enrollment
    @program = Program.find(params[:id])
    @ts = TermStudent.find(params[:term_student_id])
    render :layout => 'standalone'
  end

  def update_enrollment
    @ts = TermStudent.find(params[:ts][:id])
    if @ts.update_attributes(params[:ts])
      flash[:notice] = "Inscripción actualizada"
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @cs
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la inscripción"
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @cs.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @cs
          end
        end
      end
    end
  end

  def schedule_table
    @tc = TermCourse.where('term_id = :t AND course_id = :c', {:t => params[:term_id], :c => params[:course_id]}).first
    render :layout => false
  end

  def select_courses_for_term
    @program = Program.find(params[:id])
    @term = Term.find(params[:term_id])
    @courses_assigned = TermCourse.where("term_id = :t AND status = :s", {:t => @term.id, :s => TermCourse::ASSIGNED}).collect {|i| i.course_id}
    render :layout => 'standalone'
  end

  def assign_courses_to_term
    @term = Term.find(params[:term_id])
    if !params[:courses].nil?
      courses = params[:courses].collect {|i| i.to_i}
    else 
      courses = []
    end
    @term.assign_courses(courses)
    render :layout => 'standalone'
  end

  def new_schedule
    @program = Program.find(params[:id])
    @tc = TermCourse.where('term_id = :t AND course_id = :c', {:t => params[:term_id], :c => params[:course_id]}).first
    @staffs = Staff.order('first_name').includes(:institution)
    @institutions = Institution.order('name')
    render :layout => 'standalone'
  end

  def create_schedule
    @tc = TermCourse.find(params[:term_course_id])
    if @tc.update_attributes(params[:term_course])
      flash[:notice] = "Sesión creada."
    else
      flash[:error] = "Error al crear sesión."
    end
    render :layout => 'standalone'
  end

  def edit_schedule
    @program = Program.find(params[:id])
    @cs = TermCourseSchedule.find(params[:term_course_schedule_id])
    @staffs = Staff.order('first_name').includes(:institution)
    @institutions = Institution.order('name')
    render :layout => 'standalone'
  end

  def update_schedule
    @cs = TermCourseSchedule.find(params[:cs][:id])
    if @cs.update_attributes(params[:cs])
      if (@cs.status == TermCourseSchedule::INACTIVE) 
        flash[:notice] = "Sesión dada de baja."
      else
        flash[:notice] = "Sesión actualizada."
      end
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @cs
          end
        end
      end
    else
      flash[:error] = "Error al actualizar la sesión"
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @cs.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @cs
          end
        end
      end
    end
  end

  def students_table
    @tc = TermCourse.where('term_id = :t AND course_id = :c', {:t => params[:term_id], :c => params[:course_id]}).first
    render :layout => false
  end

  def new_course_student
    @program = Program.find(params[:id])
    @tc = TermCourse.where('term_id = :t AND course_id = :c', {:t => params[:term_id], :c => params[:course_id]}).first
    render :layout => 'standalone'
  end

  def create_course_student
    @tc = TermCourse.find(params[:term_course_id])
    if @tc.update_attributes(params[:term_course])
      flash[:notice] = "Estudiante agregado."
    else
      flash[:error] = "Error al agregar estudiante."
    end
    render :layout => 'standalone'
  end

  def edit_course_student
    @program = Program.find(params[:id])
    @cs = TermCourseStudent.find(params[:term_course_student_id])
    raise "Programs doesn't match" if @program.id != @cs.term_course.term.program_id
    render :layout => 'standalone'
  end

  def update_course_student
    @cs = TermCourseStudent.find(params[:cs][:id])
    if @cs.update_attributes(params[:cs])
      flash[:notice] = "Estudiante actualizado."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @cs
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
            json[:errors] = @cs.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @cs
          end
        end
      end
    end
  end

  def inactive_course_student
    @cs = TermCourseStudent.find(params[:term_course_student_id])
    params[:cs] = {:status => TermCourseStudent::INACTIVE}
    if @cs.update_attributes(params[:cs])
      flash[:notice] = "Estudiante dado de baja."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @cs
          end
        end
      end
    else
      flash[:error] = "Error al desactivar al estudiante."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @cs.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @cs
          end
        end
      end
    end
  end

end
