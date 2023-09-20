class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    if current_user.admin == false
      redirect_to tasks_path, notice: "アクセスに失敗しました！"
    end
  end

  def new
    @user = User.new
    if current_user.admin == false
      redirect_to tasks_path, notice: "アクセスに失敗しました！"
    end
  end

  def create
    @user = User.new
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを登録出来ました！"
    else
      render :new, notice: "登録に失敗しました"
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.admin == false
      redirect_to tasks_path, notice: "アクセスに失敗しました！"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザー情報を編集しました！"
    else
      render :edit, notice: "ユーザー情報の編集に失敗しました"
    end
  end

  def show 
    @user = User.find(params[:id])
    if current_user.admin == false
      redirect_to tasks_path, notice: "アクセスに失敗しました！"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: "管理者がユーザーを削除しました！"
    else
      redirect_to admin_users_path, notice: "管理者は最低でも一人以上必要なので削除できませんでした"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
