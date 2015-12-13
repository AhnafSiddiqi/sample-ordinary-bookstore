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

  def insert_store_manager_db(user)
    id = user.id
    query = "INSERT INTO customers (id) VALUES ('#{id}')"
    StoreManager.connection.execute(query)
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

  def find_book_by(isbn)
    book = Book.find_by_sql("SELECT * FROM books WHERE isbn13 = '#{isbn}'")
    book[0]
  end

  def find_customer_by(id)
    customer = Customer.find_by_sql("SELECT * FROM customers WHERE id = '#{id}'")[0]
  end

  def update_book(params)
    isbn13 = params[:isbn13]
    copies = params[:copies]
    query = "UPDATE books SET
             copies=#{copies}
             WHERE
             isbn13 = '#{isbn13}'"
    Book.connection.execute(query)
  end

  def update_customer(params)
    id = params[:id]
    name = params[:name]
    mobile = params[:mobile]
    address = params[:address]
    cc_no = params[:cc_no]
    query = "UPDATE customers SET
            name = '#{name}', mobile = '#{mobile}', address = '#{address}', cc_no = '#{cc_no}'
            WHERE
            id = '#{id}'"
    Customer.connection.execute(query)
  end

  def customer_book_review(customer_id, book_id)
    customer = find_customer_by(customer_id)
    c_id = customer.id
    book = find_book_by(book_id)
    b_id = book.id

    review = Review.find_by_sql("SELECT * FROM reviews where customer_id = '#{c_id}' and book_id = '#{b_id}'")[0]
  end

  def get_book_reviews(book_id)
    reviews = Review.find_by_sql("SELECT * from reviews WHERE book_id = '#{book_id}'")
  end

  def insert_review_rating_db(params)
    c = params[:customer_id]
    c2 = params[:customer_id2]
    b = params[:book_id]
    r = params[:rating]
    query = "INSERT INTO review_ratings
            (customer_id, customer_id2, book_id, rating)
            VALUES
            ('#{c}','#{c2}','#{b}','#{r}')"
    ReviewRating.connection.execute(query)
  end

  def insert_review_db(review_params)
    c_id = review_params[:customer_id]
    b_id = review_params[:book_id]
    score = review_params[:score]
    comment = review_params[:comment]
    r_date = review_params[:review_date]
    query = "INSERT INTO reviews (customer_id, book_id, score, comment, review_date) VALUES ('#{c_id}','#{b_id}','#{score}','#{comment}', '#{r_date}')"
    Review.connection.execute(query)
  end
end
