class Share < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  # validates :share_amount, presence: true
end
