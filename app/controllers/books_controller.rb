class BooksController < ApplicationController
  
  def index
    @books = Book.all()
    @order = Order.new
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create 
  end

  def update 
  end

end
