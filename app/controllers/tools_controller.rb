class ToolsController < ApplicationController
  before_action :set_tool, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new]
  before_action :check_owner, only: [:edit, :update, :destroy]
  # le controller des outils, il permet de créer, modifier, supprimer et voir les outils.
  # GET /tools or /tools.json
  def index
    @tools = Tool.all
    # On récupère tous les outils
    @markers = @tools.map do |tool| # On boucle sur les outils
      { # On crée un hash avec les infos de l'outil
        lat: tool.latitude,
        lng: tool.longitude,
        name: tool.title,
        location: tool.location,
        id: tool.id
      }
    end
  end

  # GET /tools/1 or /tools/1.json
  def show
    @tool = Tool.find(params[:id])
  end

  # GET /tools/new
  def new
    @tool = current_user.tools.build # On crée un nouvel outil, on le lie à l'utilisateur avec current_user et la méthode build
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools or /tools.json
  def create
    @tool = current_user.tools.build(tool_params) # On crée un nouvel outil, on le lie à l'utilisateur avec current_user et la méthode build

    respond_to do |format|
      if @tool.save
        format.html { redirect_to tool_url(@tool), notice: "Tool was successfully created." }
        format.json { render :show, status: :created, location: @tool }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tools/1 or /tools/1.json
  def update
    respond_to do |format|
      if @tool.update(tool_params)
        format.html { redirect_to tool_url(@tool), notice: "Tool was successfully updated." }
        format.json { render :show, status: :ok, location: @tool }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tools/1 or /tools/1.json
  def destroy
    @tool.destroy

    respond_to do |format|
      format.html { redirect_to tools_url, notice: "Tool was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end
 # On vérifie que l'utilisateur est bien le propriétaire de l'outil
    def check_owner 
      redirect_to @tool, alert:"Vous ne pouvez pas modifier cet outil" unless current_user == @tool.user
    end

    # Only allow a list of trusted parameters through.
    def tool_params # On définit les paramètres d'un outil
      params.require(:tool).permit(:title, :description, :pic, :loan, :location, :caution, :condition)
    end
end
