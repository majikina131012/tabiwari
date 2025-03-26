class CreateShares < ActiveRecord::Migration[6.1]
  def change
    create_table :shares do |t|
      t.integer :user_id, null: :false
      t.integer :expense_id, null: :false
      t.float :share_amount, null: :false

      t.timestamps
    end
  end
end
