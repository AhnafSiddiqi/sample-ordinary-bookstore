class BooksController < ApplicationController
  
  def index
    @books = Book.all()
  end

  def create 
  end

  def update 
  end

end
