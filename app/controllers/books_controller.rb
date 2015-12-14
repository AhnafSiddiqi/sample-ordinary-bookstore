class BooksController < ApplicationController
  def index
    @books = Book.all
    @order = Order.new
    @ordered_books = session[:items] unless session[:items].nil?
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
    @book = find_book_by(params[:id])
    params = book_params
    params[:isbn13] = @book.isbn13
    if update_book(params)
      flash[:success] = 'updated copies successfully'
    else
      flash[:warning] = 'update failed'
    end
    render :show
  end

  def show
    @book = find_book_by(params[:id])
    if (params[:n_useful_feedbacks].present?)
      @n_useful_reviews = retrieve_n_reviews(params[:id], params[:n_useful_feedbacks][:value])
      # byebug
      render 'show'
    end
  end

  private

  def book_params
    params.require(:book).permit(:id, :isbn13, :title, :format, :publisher, :year_of_publication, :copies, :subject, :keywords, :price, :authors)
  end
end
