class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :expenses

  validates :name, presence: true

  def includesUser?(user)
    users.exists?(id: user.id)
  end

  def optimized_settlements
    # 差額計算
    balance = Hash.new(0)

    shares = Share.joins(:expense).where(expenses: { group_id: id })

    shares.each do |share|
      balance[share.user_id] += share.pay.to_f
      balance[share.user_id] -= share.must_pay.to_f
    end

    # 正負分け
    creditors = balance.select { |_, v| v > 0 }.to_a.sort_by { |_, v| -v } # 多く払った人
    debtors   = balance.select { |_, v| v < 0 }.to_a.sort_by { |_, v| v }  # 払い足りない人

    settlements = []

    # 支払い処理
    debtors.each do |debtor_id, debt_amount|
      debt_amount = -debt_amount

      creditors.each_with_index do |(creditor_id, credit_amount), i|
        next if credit_amount <= 0

        payment = [debt_amount, credit_amount].min

        settlements << {
          from: User.find(debtor_id),
          to: User.find(creditor_id),
          amount: payment.round
        }

        balance[debtor_id] += payment
        balance[creditor_id] -= payment

        creditors[i][1] -= payment
        debt_amount -= payment

        break if debt_amount <= 0
      end
    end

    settlements
  end
  

end
