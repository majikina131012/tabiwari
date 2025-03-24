class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :expenses

  def is_owned_by?(user)
    owner_id == user.id
  end

  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  def calculate_balances
    balances = Hash.new(0)

    expenses.each do |expense|
      total_amount = expense.amount
      payer = expense.payer
      members = expense.expense_shares.map(&:user)

      share = total_amount / members.count

      members.each do |member|
        balances[member] -= share
      end
      balances[payer] += total_amount
    end

    # 誰が誰にいくら払うべきかを計算
    transactions = []
    creditors = balances.select { |_, v| v > 0 }.sort_by { |_, v| -v }
    debtors = balances.select { |_, v| v < 0 }.sort_by { |_, v| v.abs }

    while debtors.any? && creditors.any?
      debtor, debt_amount = debtors.first
      creditor, credit_amount = creditors.first

      payment = [debt_amount.abs, credit_amount].min
      transactions << { from: debtor, to: creditor, amount: payment }

      debtors.first[1] += payment
      creditors.first[1] -= payment

      debtors.shift if debtors.first[1].zero?
      creditors.shift if creditors.first[1].zero?
    end

    transactions
  end
end
