class LoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan, only: %i[ show edit update destroy ]
  before_action :set_tool, only: [:new, :create]
  before_action :check_loan_status, only: [:new, :create]
  before_action :users_tool, only: [:new, :create]
  before_action :only_borrower_and_owner, only: [:edit, :update, :destroy]
  # Le controller des emprunts, il permet de créer, modifier, supprimer et voir les emprunts.
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
    @tool = @loan.tool
    @loan = Loan.find(params[:id])
  end
  # le create permet de créer un nouvel emprunt, il prend en paramètre le tool_id et le user_id, il est lié à un outil et à un utilisateur.
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
  # le update permet de modifier un emprunt, il prend en paramètre le tool_id et le user_id, il est lié à un outil et à un utilisateur.
  # PATCH/PUT /loans/1 or /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to loan_url(@loan), notice: "L'emprunt à bien été modifié" }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end
  # le destroy permet de supprimer un emprunt, il prend en paramètre le tool_id et le user_id, il est lié à un outil et à un utilisateur.
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
    # le set_loan permet de trouver un emprunt en fonction de son id.
    def set_loan
      @loan = Loan.find(params[:id])
    end
    # le loan_params permet de définir les paramètres d'un emprunt.
    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:start_date, :end_date)
    end
    # le set_tool permet de trouver un outil en fonction de son id.
    def set_tool
      @tool = Tool.find(params[:tool_id])
    end
    # le check_loan_status permet de vérifier si l'outil est déjà emprunté.
    def check_loan_status
      if @tool.loaned?
        redirect_to tools_path, notice: "Cet outil est déjà emprunté."
      end
    end
    # le users_tool permet de vérifier si l'utilisateur est le propriétaire de l'outil.
    def users_tool
      if current_user.id == @tool.user.id
        redirect_to tools_path, notice: "Vous ne pouvez pas emprunter votre propre outil."
      end
    end
    # le only_borrower_and_owner permet de vérifier si l'utilisateur est le propriétaire de l'outil ou l'emprunteur.
    def only_borrower_and_owner
      if current_user.id != @loan.user.id && current_user.id != @loan.tool.user.id
        redirect_to tools_path, notice: "Vous n'êtes pas autorisé à modifier cet emprunt."
      end
    end

end
