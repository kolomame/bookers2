class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book)
    else
      redirect_to book_path(book)
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_to book_path(book_comment.book.id)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
