class BooksController < ApplicationController
    def index
        # 本の一覧を表示するため、「@books」を取得する。
        @books = Book.all
        # NewBook投稿フォーム用の「@book_new」を作る。
        @book_new = Book.new
    end
    def show
        # 本を判別するためのidを取得する
        @book = Book.find(params[:id])
        # ユーザを判別するための「@user」を取得する。
        @user = @book.user
        # NewBook投稿フォーム用の「@book_new」を作る。
        @book_new = Book.new
    end
    def create
        # 実際に本を投稿するため、ストロングパラメータを使って登録していく。
        @book_new = Book.new(book_params)
        # 投稿する際に、新しく作成されるbookに対して、自分でカラムを作成した「user_id」の値を入れてあげなければいけない。
        # ここでそのidは「current_user.id」だよと指定してあげてる。
        @book_new.user_id = current_user.id
        # もし、saveに成功したら、作成したbookのpathにリダイレクトして、noticeを表示して、異なる場合（validatesで引っ掛かったとか）は、indexにrenderする。
        if @book_new.save
            redirect_to book_path(@book_new.id), notice: "You have creatad book successfully."
        else
            @books = Book.all
            render :index
        end
    end
    def edit
        # まずは、編集する「@book」を取得する
        @book = Book.find(params[:id])
        # もし、@bookの「user」が現在ログインしているユーザと一緒ならば、「edit」にいってもOK。違うなら、books_pathにはじく。
        if @book.user == current_user
            render :edit
        else
            redirect_to books_path
        end
    end
    def update
        # まずは、updateするidを取得
        @book = Book.find(params[:id])
        # もし、updateにストロングパラメータを使って成功したら、更新したbookのページにリダイレクトしてnoticeし、異なる場合（validatesではじかれる）editページに戻してエラーを表示する
        if @book.update(book_params)
            redirect_to book_path(@book.id), notice: "You have updated book successfully."
        else
            render :edit
        end
    end
    def destroy
        # 削除するidを取得する
        @book = Book.find(params[:id])
        # 実際に削除する
        @book.destroy
        # books一覧にリダイレクトする
        redirect_to books_path
    end

    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
    
end
