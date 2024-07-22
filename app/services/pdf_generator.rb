# app/services/pdf_generator.rb
require 'prawn'

class PdfGenerator
  def initialize(loan)
    @loan = loan
  end

  def generate
    Prawn::Document.new do |pdf|
      pdf.text "Loan Details", size: 30, style: :bold
      pdf.move_down 20

      pdf.text "Address: #{@loan.address}"
      pdf.text "Loan Term: #{@loan.loan_term}"
      pdf.text "Purchase Price: $#{@loan.purchase_price}"
      pdf.text "Repair Budget: $#{@loan.repair_budget}"
      pdf.text "After Repair Budget: $#{@loan.after_repair_value}"
      pdf.text "Name: #{@loan.name}"
      pdf.text "Email: #{@loan.email}"
      pdf.text "Phone: #{@loan.phone}"

      pdf.text "Estimated Profit: $#{@loan.estimated_profit}"

      # Adding some more space before end
      pdf.move_down 20
      pdf.text "Generated on: #{Time.now.strftime('%B %d, %Y')}"
    end.render
  end
end
