class ProgramsController < ApplicationController
  before_filter :auth_required
  respond_to :html, :xml, :json

  def index
  end

  def live_search
    @programs = Program.order('name')
    if !params[:q].blank?
      @programs = @programs.where("name LIKE :n OR code LIKE :n)", {:n => "%#{params[:q]}%"}) 
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
    @program = Program.new(params[:institution])

    if @program.save
      flash[:notice] = "Programa creada."

      respond_with do |format|
        format.html do
          if request.xhr?
            json = {}
            json[:flash] = flash
            json[:uniq] = @program.id
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

    if @program.update_attributes(params[:institution])
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
end
