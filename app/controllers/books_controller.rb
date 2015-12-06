class BooksController < ApplicationController
  
  def index
    @books = Book.all()
    @order = Order.new
  end

  def create 
  end

  def update 
  end

end
