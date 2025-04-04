class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :expenses

  def includesUser?(user)
    users.exists?(id: user.id)
  end

  # def calculate_balances
  #   balances = Hash.new(0)
  #   expenses.each do |expense|
  #     total_amount = expense.amount
  #     payer = expense.payer
  #     members = expense.shares.map(&:user)

  #     share = total_amount / members.count.to_f

  #     members.each do |member|
  #       balances[member] -= share
  #     end
  #     balances[payer] += total_amount
  #   end

  #   # 誰が誰にいくら払うべきかを計算
  #   transactions = []
  #   creditors = balances.select { |_, v| v > 0 }.sort_by { |_, v| -v }
  #   debtors = balances.select { |_, v| v < 0 }.sort_by { |_, v| v.abs }

  #   while debtors.any? && creditors.any?
  #     debtor, debt_amount = debtors.first
  #     creditor, credit_amount = creditors.first

  #     payment = [debt_amount.abs, credit_amount].min
  #     transactions << { from: debtor, to: creditor, amount: payment }

  #     debtors.first[1] += payment
  #     creditors.first[1] -= payment

  #     debtors.shift if debtors.first[1].zero?
  #     creditors.shift if creditors.first[1].zero?
  #   end

  #   transactions
  # end


  def calculate_balances
    balances = Hash.new { |hash, key| hash[key] = 0.0 }
  
    expenses.each do |expense|
      total_amount = expense.amount
      payer = expense.payer
      members = expense.shares.map(&:user)
  
      next if members.empty? # 割り勘対象がいない場合はスキップ
  
      share = total_amount / members.count.to_f
  
      members.each do |member|
        balances[member] -= share
      end
      balances[payer] += total_amount
    end
  
    transactions = []
    creditors = balances.select { |_, v| v > 0 }.map { |k, v| { user: k, amount: v } }.sort_by { |h| -h[:amount] }
    debtors = balances.select { |_, v| v < 0 }.map { |k, v| { user: k, amount: v.abs } }.sort_by { |h| h[:amount] }
  
    while debtors.any? && creditors.any?
      debtor = debtors.first
      creditor = creditors.first
  
      payment = [debtor[:amount], creditor[:amount]].min
      transactions << { from: debtor[:user], to: creditor[:user], amount: payment }
  
      debtor[:amount] -= payment
      creditor[:amount] -= payment
  
      debtors.shift if debtor[:amount].zero?
      creditors.shift if creditor[:amount].zero?
    end
  
    transactions
  end
  

end
