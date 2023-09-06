class BooksController < ApplicationController
  def new
    @book_new = Book.new
    @user_new = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      @books = Book.all
      @book_new = Book.new
      @user_new = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @book_new = Book.new
    @user_new = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user_new = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
