module SqlHelper

  # Inserts
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

  def insert_order_items_db(params)
    order_id = params[:order_id]
    book_id = params[:book_id]
    copies = params[:copies]
    query = "INSERT INTO order_items (order_id, book_id , copies) VALUES ('#{order_id}','#{book_id}','#{copies}')"
    OrderItem.connection.execute(query)
  end

  def insert_book_db(params)
    isbn13 = params[:book][:isbn13]
    title = params[:book][:title]
    format = params[:book][:format]
    publisher = params[:book][:publisher]
    year_of_publication = params[:book][:year_of_publication]
    copies = params[:book][:copies]
    keywords = params[:book][:keywords]
    subject = params[:book][:subject]
    price = params[:book][:price]
    authors = params[:book][:authors]

    query = "INSERT INTO books (isbn13, title, format, publisher, year_of_publication, copies, keywords, subject, price,
            authors) VALUES (#{isbn13}, #{title}, #{format}, #{publisher}, #{year_of_publication}, #{copies}, #{keywords},
            #{subject}, #{price}, #{authors})"
    Book.connection.execute(query)
  end

  # Updates
  def update_order_status(order_id, status)
    query = "UPDATE orders SET status = '#{status}' WHERE id = '#{order_id}'"
    Order.connection.execute(query)
    session.delete(:items)
  end

  # Find
  def find_pending_order(user)
    user_id = user.id
    order_id = Order.find_by_sql("SELECT id FROM orders WHERE status = 'pending' AND customer_id = '#{user_id}'")
  end

  def book_copies_in_store(isbn)
    book = Book.find_by_sql("SELECT copies FROM books WHERE isbn13 = '#{isbn}'")
    book[0].copies
  end

  def find_book_by (isbn)
    book = Book.find_by_sql("SELECT * FROM books WHERE isbn13 = '#{isbn}'")
    book[0]
  end

end
  