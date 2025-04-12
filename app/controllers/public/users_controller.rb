class Public::UsersController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to request.referer
      flash[:notice] = "名前の変更に成功しました。"
    else
      render 'edit'
    end
  end
  private
  def user_params
    params.require(:user).permit(:name)
  end
end
