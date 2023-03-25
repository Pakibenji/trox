class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show edit update destroy ]
  before_action :set_tool, only: [:new, :create]
  before_action :check_loan_status, only: [:new, :create]


  # GET /loans or /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1 or /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @tool = Tool.find(params[:tool_id])
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans or /loans.json
  def create
    @tool = Tool.find(params[:tool_id])
    @loan = Loan.new(loan_params)
    @loan.tool = @tool
    @loan.user = current_user

    if @loan.save
      redirect_to @loan
    else
      render 'new'
    end
  end

  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to loan_url(@loan), notice: "Loan was successfully updated." }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1 or /loans/1.json
  def destroy
    @loan.destroy

    respond_to do |format|
      format.html { redirect_to loans_url, notice: "Loan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:start_date, :end_date)
    end

    def set_tool
      @tool = Tool.find(params[:tool_id])
    end
  
    def check_loan_status
      if @tool.loaned?
        redirect_to tools_path, notice: "Cet outil est déjà loué."
      end
    end
end
