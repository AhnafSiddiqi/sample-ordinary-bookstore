class OrderItemsController < ApplicationController 

  def create

  end

  def add
    puts params
    isbn = params[:book]
    store_request isbn
    puts session[:items]
    redirect_to books_path
  end

  private 

    def store_request(isbn)
      session[:items].nil? ? session[:items] = {} : 0
      session[:items][isbn].nil? ? session[:items][isbn] = 1 : session[:items][isbn] += 1
    end

end