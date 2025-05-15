class Public::HomesController < ApplicationController
  def top
    if user_signed_in? 
      @user = current_user
      @groups = current_user.groups
    end
  end

  def error
  end
end
