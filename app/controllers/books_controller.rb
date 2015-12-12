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

  def create 
  end

  def update 
  end

end
