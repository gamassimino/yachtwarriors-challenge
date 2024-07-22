class Loan < ApplicationRecord
  validates :loan_term, comparison: { greater_than: 0 }
  
  validate :amount_within_purchase_price_limit
  validate :amount_within_after_repair_value_limit

  private

  def amount_within_purchase_price_limit
    if purchase_price.present? && amount > 0.9 * purchase_price
      errors.add(:amount, "Max Loan Amount by Purchase Price = 90% of Purchase Price")
    end
  end

  def amount_within_after_repair_value_limit
    if after_repair_value.present? && amount > 0.7 * after_repair_value
      errors.add(:amount, "Max Loan Amount by ARV = 70% of ARV")
    end
  end
end
