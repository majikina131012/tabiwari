class Public::ExpensesController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.new(expense_params)
  
    if @expense.save
      user_ids = params[:expense][:user_ids].reject(&:blank?).map(&:to_i)
      share_amount = @expense.amount / user_ids.size.to_f
  
      user_ids.each do |user_id|
        @expense.shares.create(
          user_id: user_id,
          must_pay: share_amount,
          pay: user_id == @expense.payer_id ? @expense.amount : 0,
          pay_to_user_id: @expense.payer_id == user_id ? nil : @expense.payer_id
        )
      end
  
      redirect_to group_path(@group)
    else
      render :new
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
