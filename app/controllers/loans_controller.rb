class LoansController < ApplicationController
  def index
    @loan = Loan.new
  end

  def create
    loan_service = CreateLoan.new(loan_params)
    loan_service.call

    if loan_service.errors.present?
      @loan = loan_service.loan
      render :index
    else
      redirect_to loans_path
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:address, :loan_term, :purchase_price,
                                 :repair_budget, :after_repair_value,
                                 :name, :email, :phone)
  end
end
