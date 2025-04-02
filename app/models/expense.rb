class Expense < ApplicationRecord
  belongs_to :payer, class_name: "User"
  belongs_to :group
  has_many :shares
  has_many :users, through: :shares

  def formatted_created_at
    created_at.strftime("%Y-%m-%d %H:%M")
  end
end
