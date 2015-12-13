class CustomersController < ApplicationController

  def show
    @customer = current_customer
    @order_history = retrieve_customer_order_history(@customer.id)
  end

  def update
    @customer = current_customer
    if update_customer(customer_params)
      # if @customer.update_attributes(customer_params)
      flash.now[:success] = 'Update successful'
    else
      flash.now[:warning] = 'Update unsuccessful, Try again'
    end
    render :show
  end

  private

    def customer_params
      params.require(:customer).permit(:id, :name, :mobile, :address, :cc_no)
    end
    
end
