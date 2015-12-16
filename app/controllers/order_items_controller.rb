class OrderItemsController < ApplicationController
  
  def create
    params[:items][:isbn13].each do |book|
      book_index = params[:items][:isbn13].index(book)
      items = OrderItem.new(order_items_params(book_index))
      if items.valid?
        if (params[:copies].to_i > 0)
          insert_order_items_db(params)
          update_book_copies(params)
        end
      end
    end
    update_order_status(params[:order_id], 'processed')
    redirect_to books_path
  end

  def add
    book = params[:book]
    puts session[:items]
    store_for_order book if copies_available? book
    redirect_to books_path
  end

  def rmv
    book = params[:book]
    remove_from_order book
    redirect_to books_path
  end

  private

  def order_items_params(index)
    populate_proper_params(index)
    params.permit(:order_id, :copies, :book_id)
  end

  def populate_proper_params(index)
    params[:order_id] = params[:order_id]
    params[:copies] = params[:items][:copies][index]
    params[:book_id] = params[:items][:isbn13][index]
  end
  
end
