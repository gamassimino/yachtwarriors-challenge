class LoanMailer < ApplicationMailer
  def send_loan_summary_email
    @loan = Loan.find(params[:loan_id])

    attachments['loan_details.pdf'] = params[:pdf]
    
    mail(to: @loan.email, subject: 'Loan Summary')
  end
end
