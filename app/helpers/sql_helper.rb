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

  def update_book_copies(params)
    ordered_copies = params[:copies]
    book_id = params[:book_id]
    current_copies = book_copies_in_store(book_id)
    updated_copies = ordered_copies.to_i - current_copies.to_i
    query = "UPDATE books SET copies = '#{updated_copies}' WHERE isbn13 = '#{book_id}'"
    Book.connection.execute(query)
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

  def find_all_books
    Book.find_by_sql("SELECT * FROM books")
  end

  def find_all_sorted_by(sort)
    if sort == "year_of_publication"
      Book.find_by_sql("SELECT * FROM books ORDER BY #{sort} DESC")
    else 
      # Not done yet
      Book.find_by_sql("SELECT * FROM books ORDER BY #{sort} DESC")
    end
  end

  def find_by_isbn (isbn)
    book = Book.find_by_sql("SELECT * FROM books WHERE isbn13 = '#{isbn} DESC'")
    book[0]
  end

  def find_by_one_column(column, value, sort)
    if sort == "year_of_publication"
      collection = Book.find_by_sql("SELECT * FROM books WHERE #{column} LIKE '%#{value}%' ORDER BY #{sort} DESC")
    else 
      # Not done yet
      collection = Book.find_by_sql("SELECT * FROM books WHERE #{column} LIKE '%#{value}%' ORDER BY #{sort} DESC")
    end
    collection
  end

  def find_by_two_column(columns, values, operator ,sort)
    begin
      if sort == "year_of_publication"
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%'  ORDER BY #{sort} DESC")
      else 
        # Not done yet
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%'  ORDER BY #{sort} DESC")
      end
      collection
    rescue 
      false
    end
  end

  def find_by_three_column(columns, values, operator ,sort)
    begin 
      if sort == "year_of_publication"
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%' #{operator} #{columns[2]} LIKE '%#{values[2]}%'  ORDER BY #{sort} DESC")
      else 
        # Not done yet
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%'  ORDER BY #{sort} DESC")
      end
      collection
    rescue
      false
    end
  end

  def find_by_four_column(columns, values, operator ,sort)
    begin
      if sort == "year_of_publication"
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%' #{operator} #{columns[2]} LIKE '%#{values[2]}%' #{operator} #{columns[3]} LIKE '%#{values[3]}%'  ORDER BY #{sort} DESC")
      else 
        # Not done yet
        collection = Book.find_by_sql("SELECT * FROM books WHERE #{columns[0]} LIKE '%#{values[0]}%' #{operator} #{columns[1]} LIKE '%#{values[1]}%'  ORDER BY #{sort} DESC")
      end
      collection
    rescue
      false
    end
  end

end
  