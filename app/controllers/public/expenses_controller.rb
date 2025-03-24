class Public::ExpensesController < ApplicationController
  def create
    expense = Expense.new(expense_params)
    expense.group_id = Group.find(params[:group_id])
    if expense.save!
      redirect_to request.referer
    else
      render root_path
    end
  end

  private
  def expense_params
    params.require(:expense).permit(:amount, :description, :payer_id, :group_id)
  end
end
