class ToolsController < ApplicationController
  before_action :set_tool, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new]
  before_action :check_owner, only: [:edit, :update, :destroy]

  # GET /tools or /tools.json
  def index
    @tools = Tool.all
  end

  # GET /tools/1 or /tools/1.json
  def show
  end

  # GET /tools/new
  def new
    @tool = current_user.tools.build
  end

  # GET /tools/1/edit
  def edit
  end

  # POST /tools or /tools.json
  def create
    @tool = current_user.tools.build(tool_params)

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

    def check_owner 
      redirect_to @tool, alert:"Vous ne pouvez pas modifier cet outil" unless current_user == @tool.user
    end

    # Only allow a list of trusted parameters through.
    def tool_params
      params.require(:tool).permit(:title, :description, :pic, :loan, :location, :caution, :condition)
    end
end
