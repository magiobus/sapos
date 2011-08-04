class ClassroomsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
  end

  def live_search
    @classrooms = Classroom.order('code')
    puts "antes"
    puts @classrooms.to_s
    puts "pasa"
    if !params[:q].blank?
      @classrooms = @classrooms.where("(name LIKE :n OR code LIKE :n)", {:n => "%#{params[:q]}%"}) 
    end

    render :layout => false
  end

  def show
    @classroom = Classroom.find(params[:id])
    render :layout => false
  end

  def new
    @classroom = Classroom.new
    render :layout => false
  end

  def create
    @classroom = Classroom.new(params[:classroom])

    if @classroom.save
      flash[:notice] = "Aula creada."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @classroom.code
            render :json => json
          else 
            redirect_to @classroom
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
            json[:errors] = @classroom.errors
            render :json => json, :status => :unprocessable_entity
          else
            redirect_to @classroom
          end
        end
      end
    end
  end

  def update 
    @classroom = Classroom.find(params[:id])

    if @classroom.update_attributes(params[:classroom])
      flash[:notice] = "Aula actualizada."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            render :json => json
          else 
            redirect_to @classroom
          end
        end
      end
    else
      flash[:error] = "Error al actualizar aula."
      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:errors] = @classroom.errors
            render :json => json, :status => :unprocessable_entity
          else 
            redirect_to @classroom
          end
        end
      end
    end
  end
end
