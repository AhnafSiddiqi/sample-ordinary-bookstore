class CustomersController < ApplicationController
  def show
    @customer = current_customer
    @order_history = retrieve_customer_order_history(@customer.id)
    @current_user_reviews = retrieve_current_user_reviews(@customer.id)
    @current_user_ranked_reviews = retrieve_user_ranked_reviews(@customer.id)
    @recommended_books = get_recommended_books(@customer.id)
  end

  def update
    @customer = current_customer
    if update_customer(customer_params)
      flash.now[:success] = 'Update successful'
    else
      flash.now[:warning] = 'Update unsuccessful, Try again'
    end
    redirect_to customer_path
  end

  private

  def customer_params
    params.require(:customer).permit(:id, :name, :mobile, :address, :cc_no)
  end
end
