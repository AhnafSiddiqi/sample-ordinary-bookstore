class OrdersController < ApplicationController

  def show
    @order = Order.find_by_sql("SELECT * FROM orders WHERE id = '#{params[:id]}'")[0]
    @orders = populate_order_list
    render 'show'
  end

  def create
    order = Order.new(orders_param)
    if order.valid?
      insert_order_db (params)
      redirect_to books_path
    else
      render 'books/index'
    end      
  end

  def destroy
    cancel_order params[:order_id]
    redirect_to books_path
  end

  private
    def orders_param
      populate_order_params
      params.permit(:customer_id, :order_date, :status)
    end

    def populate_order_params
      params[:order_date] = Time.now.to_s
      params[:status] = "pending"
    end

end
