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
    member = Membership.find_by(user_id: current_user.id)
    if member.destroy
      redirect_to request.referer
    else
      render groups_path
    end
  end
end
