require "ostruct"

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

  def schedule_table
    @tc = TermCourse.where('term_id = :t AND course_id = :c', {:t => params[:term_id], :c => params[:course_id]}).first
    render :layout => false
  end

end
