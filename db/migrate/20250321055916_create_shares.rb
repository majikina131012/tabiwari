class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.integer :user_id, null: :false
      t.integer :expense_id, null: :false
      t.float :burden_amount, null: :false
      t.float :must_pay, null: :false
      t.float :pay, null: :false
      t.integer :pay_to_user_id, null: :false

      t.timestamps
    end
  end
end
