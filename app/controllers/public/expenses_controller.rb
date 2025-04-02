class Public::ExpensesController < ApplicationController
  def create
    expense = Expense.new(expense_params.except(:user_ids)) # user_idsを除外してExpenseを作成
    expense.group_id = params[:group_id]
    if expense.save
      expense_params[:user_ids].each do |user_id|
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
    params.require(:expense).permit(:amount, :description, :payer_id).merge(user_ids: params[:expense].fetch(:user_ids, []).reject(&:blank?))
  end
end
