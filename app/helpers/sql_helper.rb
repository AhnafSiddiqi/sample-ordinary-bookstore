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

  def retrieve_m_popular_books(m)
    start_of_month = Date.today.beginning_of_month.to_s
    query = "SELECT title, isbn13, sum
             FROM 
             (SELECT SUM(copies), book_id FROM 
             (SELECT copies, book_id FROM 
             orders 
             INNER JOIN 
             order_items 
             ON 
             orders.id = order_items.order_id 
             WHERE order_date > '#{start_of_month}')
             AS temp
             GROUP BY
             book_id
             ORDER BY 
             SUM(copies)
             DESC)
             AS notebook
             INNER JOIN 
             books
             ON 
             book_id = isbn13
             LIMIT #{m}"
    ActiveRecord::Base.connection.execute(query)
  end


  def retrieve_m_popular_authors(m)
    start_of_month = Date.today.beginning_of_month.to_s
    query = "SELECT title, authors, isbn13
             FROM
             (SELECT SUM(copies), book_id FROM 
             (SELECT copies, book_id FROM 
             orders 
             INNER JOIN 
             order_items 
             ON 
             orders.id = order_items.order_id 
             WHERE order_date > '#{start_of_month}')
             AS temp
             GROUP BY
             book_id
             ORDER BY 
             SUM(copies)
             DESC)
             AS auth
             INNER JOIN 
             books 
             ON auth.book_id = books.isbn13
             LIMIT #{m}"
    ActiveRecord::Base.connection.execute(query)
  end


  def retrieve_m_popular_publishers(m)
    start_of_month = Date.today.beginning_of_month.to_s
    query = "SELECT SUM(sum), publisher
             FROM
             (SELECT title, publisher, sum
             FROM
             (SELECT SUM(copies), book_id FROM 
             (SELECT copies, book_id FROM 
             orders 
             INNER JOIN 
             order_items 
             ON 
             orders.id = order_items.order_id 
             WHERE order_date > '#{start_of_month}')
             AS temp
             GROUP BY
             book_id
             ORDER BY 
             SUM(copies)
             DESC)
             AS auth
             INNER JOIN 
             books 
             ON auth.book_id = books.isbn13)
             AS pub
             GROUP BY 
             pub.publisher
             ORDER BY
             SUM(sum)
             DESC
             LIMIT #{m}"
    ActiveRecord::Base.connection.execute(query)
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
    reviews = Review.find_by_sql("SELECT * from reviews WHERE book_id = '#{book_id}' ORDER BY usefulness DESC")
  end

  def retrieve_n_reviews(book_id, n)
    Review.find_by_sql("SELECT * from reviews WHERE book_id = '#{book_id}' ORDER BY usefulness DESC LIMIT #{n}")
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

  def retrieve_customer_order_history(customer_id)
    query = "SELECT * FROM 
             (SELECT * FROM orders WHERE customer_id = '#{customer_id}') 
             AS ORDERS 
             LEFT OUTER JOIN 
             order_items 
             ON ORDERS.id = order_items.order_id"
    ActiveRecord::Base.connection.execute(query)
  end

  def retrieve_current_user_reviews(customer_id)
    query = "SELECT * FROM reviews WHERE customer_id = '#{customer_id}' ORDER BY review_date"
    Review.find_by_sql(query)
  end

  def current_user_rated_reviews(customer_id)
    query = ""
  end

  def get_review_usefulness(book, customer2)
    query = "SELECT AVG(rating) as usefulness FROM review_ratings
            WHERE
            book_id = '#{book}' AND customer_id2 = #{customer2}"
    average = ReviewRating.find_by_sql(query)[0]
    score = average.usefulness
    if score.present?
      update_usefulness_review(customer2,score)
    end
    score
  end

  private
  
    def update_usefulness_review(customer, score)
      c = customer
      query = "UPDATE reviews SET usefulness = '#{score}'
               WHERE
               customer_id= '#{c}'"
      Review.connection.execute(query)
    end

end
