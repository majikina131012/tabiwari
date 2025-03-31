class Public::MembershipsController < ApplicationController
  def create
    membership = Membership.new
    group = Group.find(params[:group_id])
    membership.user_id = current_user.id
    membership.group_id = group.id
    if membership.save
      redirect_to request.referer
    else
      render groups_path
    end
  end

  def destroy
    membership = Membership.find_by(params[:group_id])
    if membership.destroy
      redirect_to request.referer
    else
      render groups_path
    end
  end
end
