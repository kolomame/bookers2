class BooksController < ApplicationController
  def new
    @book_new = Book.new
    @user_new = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @book_new = Book.new
      @user_new = current_user
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @book_new = Book.new
    @user_new = current_user
    @user = @user_new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user_new = current_user
    @user = @book.user
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end


  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(current_user.id)
    else
      render :edit
    end
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

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end


end
