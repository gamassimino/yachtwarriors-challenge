class CreateLoan < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.string :address
      t.integer :loan_term
      t.float :purchase_price
      t.float :repair_budget
      t.float :after_repair_value
      t.float :amount
      t.float :interest_expense
      t.float :estimated_profit
      t.string :name
      t.string :email
      t.string :phone
      t.float :profit

      t.timestamps
    end
  end
end
