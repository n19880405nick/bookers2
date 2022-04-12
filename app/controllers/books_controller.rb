class BooksController < ApplicationController
  
  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:created]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
  end 
  
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.new
    @current_book = Book.find(params[:id])
    @user = @current_book.user
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:updated_book] = "You have updated book successfully."
      redirect_to book_path(params[:id])
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
    params.require(:book).permit(:title, :body)
  end
end
