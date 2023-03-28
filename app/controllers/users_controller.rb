class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def show_tools
    @user = current_user
    @tools = @user.tools
  end
end
