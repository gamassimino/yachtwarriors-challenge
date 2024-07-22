class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(loan_id)
    loan = Loan.find(loan_id)
    pdf = PdfGenerator.new(loan).generate

    LoanMailer.with(loan_id: loan.id, pdf: pdf).send_loan_summary_email.deliver_now
  end
end
