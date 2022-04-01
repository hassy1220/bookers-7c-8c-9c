class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
    @comment = BookComment.new
    @today_books = Book.where(created_at: Date.current)
  end

  def index
    to=Time.current
    from=(to - 6.day)

    @book = Book.new

    @books = Book.includes(:like_user).sort{|a,b|
     b.like_user.includes(:favorites).where(created_at: from...to).size <=>
     a.like_user.includes(:favorites).where(created_at: from...to).size}
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      @book = Book.new
      @books = Book.all
      redirect_to books_path
    end
  end
end
