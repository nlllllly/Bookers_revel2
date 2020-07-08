class UsersController < ApplicationController
  def index
    # indexページに「each」を使って全ユーザを表示するため、「@users」を取得する。
    @users = User.all
    # NewBook投稿フォーム用の「@book_new」を作る。
    @book_new = Book.new
  end
  def show
    # そのページに紐づくユーザ名を表示するために「@user」のidをまず取得する。
    @user = User.find(params[:id])
    # その取得したuserのidを使って「@user」に関連するbooksを全て取得。
    @books = @user.books
    # NewBook投稿フォーム用の「@book_new」を作る。
    @book_new = Book.new
  end
  def edit
    # そのページに紐づくユーザを表示するために「@user」のidをまず取得する。
    @user = User.find(params[:id])
    # その取得した「@user」を使って、editページにアクセスさせても良いかをif文で表す。
    # もし、そのページのユーザが、現在ログインしているユーザ（自分自身）だったならば、editページへ飛ばして、異なれば現在ログインしているユーザの「user#show」へ飛ばす。
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end
  def update
    # そのページに紐づくユーザを表示するために「@user」のidをまず取得する。
    @user = User.find(params[:id])
    # その取得した「@user」を使って、updateアクションを進めた時の処理
    # もし、ストロングパラメータを使ったupdateが成功したら、ユーザページにリダイレクトしてnoticeを表示し、成功しなければ（validatesで引っかかれば）renderする。
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
