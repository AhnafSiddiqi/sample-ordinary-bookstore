class BooksController < ApplicationController
  
  def index
    @books = Book.all()
    @order = Order.new
    if !(session[:items].nil?)
      @ordered_books = session[:items]
    end
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
