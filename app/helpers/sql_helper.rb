module SqlHelper

  def insert_user_db(params)
    login_id = params[:user][:login_id]
    password = params[:user][:password_digest]
    query = "INSERT INTO users (login_id, password_digest) VALUES ('#{login_id}','#{password}')"
    User.connection.execute(query)
  end

  def insert_customer_db(user)
    id = user.id
    query = "INSERT INTO customers (id) VALUES ('#{id}')"
    Customer.connection.execute(query)
  end

  def insert_order_db(params)
    customer_id = params[:customer_id]
    order_date  = params[:order_date]
    status = params[:status]
    query = "INSERT INTO orders (customer_id, order_date, status) VALUES ('#{customer_id}','#{order_date}','#{status}')"
    Order.connection.execute(query)
  end

  def find_pending_order(user)
    user_id = user.id
    order_id = Order.find_by_sql("SELECT id FROM orders WHERE status = 'pending' AND customer_id = '#{user_id}'")
  end

end
