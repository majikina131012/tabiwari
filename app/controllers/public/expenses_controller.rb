class Public::ExpensesController < ApplicationController
  def create
    expense = Expense.new(expense_params)
    expense.group_id = params[:group_id]
    if expense.save
      params[:expense][:user_ids].each do |user_id|#ここに支払いをシェアするメンバーをすべて取得する
        next if user_id.blank?
        Share.create(expense_id: expense.id, user_id: user_id)
      end
      redirect_to group_path(expense.group_id)
    else
      render root_path
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.users
    @expense = Expense.new
    @expenses = @group.expenses.includes(:payer, :shares)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group.expenses.destroy_all
    redirect_to group_path(@group), notice: "精算をリセットしました"
  end

  def reset_all
    @group = Group.find(params[:group_id])
    @group.expenses.destroy_all
    redirect_to group_path(@group.id), notice: "全ての精算データをリセットしました"
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :description, :payer_id, user_ids: [])
  end
end
