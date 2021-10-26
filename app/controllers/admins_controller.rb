class AdminsController < ApplicationController

  def top
    @coment = Coment.new
    @coments = Coment.where(page: "/admins")
  end

  def reques
    @coment = Coment.new
    @coments = Coment.where(page: "/admins/reques")
    @users = User.where(role: 1..2).search(params[:word]) if params[:word].present?
    @user = User.find_by(name: params[:name])
  end

  def search

  end

  def edit

  end

  def update
    if params[:users] == "更新"
      user = User.find(params[:user][:id])
      user.update(user_params)
      redirect_to admins_reques_path
    end

  end

  def destroy

  end

private

  def user_params
    params.require(:user).permit(:role)
  end

end
