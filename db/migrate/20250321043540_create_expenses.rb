class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.integer :payer_id, null: :false
      t.integer :group_id, null: :false
      t.float :amount, null: :false
      t.string :description, null: :false

      t.timestamps
    end
  end
end
