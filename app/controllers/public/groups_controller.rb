class Public::GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    if group.save
      redirect_to group_path(group.id)
    else
      render root_path
    end
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.users
    @expense = Expense.new
    @settlements = @settlements = @group.optimized_settlements
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
