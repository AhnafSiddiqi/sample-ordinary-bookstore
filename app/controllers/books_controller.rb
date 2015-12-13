class BooksController < ApplicationController
  
  def index
    temp_books = nil
    params[:search].present? ? temp_books = book_search(params[:search]) : @books = find_all_books
    if !(temp_books.nil?) 
      if (temp_books == false)
        flash.now[:danger] = "Please select the Operators at the correct level" 
        @books = find_all_books
      else 
         @books = temp_books
      end
    end
    !(session[:items].nil?) ? @ordered_books = session[:items] : 0
    @order = Order.new

    respond_to do |format|
      format.html
      format.js {}
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render :index
    else
      render :new
    end
  end

  def update
  end

  private

    def book_params
      params.require(:book).permit(:isbn13, :title, :format, :publisher, :year_of_publication, :copies, :subject, :keywords, :price, :authors)
    end
end
