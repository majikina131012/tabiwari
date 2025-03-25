class Expense < ApplicationRecord
  belongs_to :payer, class_name: "User"
  belongs_to :group
  has_many :shares
  has_many :users, through: :shares
end
