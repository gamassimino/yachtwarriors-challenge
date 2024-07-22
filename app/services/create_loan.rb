class CreateLoan
  attr_reader :loan, :errors

  def initialize(loan_params)
    @loan_params = loan_params
    @errors = nil
  end

  def call
    ActiveRecord::Base.transaction do
      @loan = Loan.new(@loan_params)
      @loan.amount = calculate_amount
      @loan.interest_expense = calculate_interest_expense
      @loan.estimated_profit = estimated_profit
      @loan.save
    end

    SendEmailJob.perform_now @loan.id

    true
  rescue Exception => e
    @errors = e
    false
  end

  private

  def calculate_amount
    amount_by_purchase_price = 0.9 * loan.purchase_price
    amount_by_arv = 0.7 * loan.after_repair_value
    [amount_by_purchase_price, amount_by_arv].min
  end

  def calculate_interest_expense
    monthly_interest_rate = 0.13 / 12
    monthly_interest_rate * loan.purchase_price * loan.loan_term
  end

  def estimated_profit
    loan.after_repair_value - loan.amount - loan.interest_expense
  end
end
