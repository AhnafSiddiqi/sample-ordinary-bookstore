module OrderItemsHelper

  def book_in_order?(isbn)
    !(session[:items].nil?) ? (session[:items].include? isbn) : false
  end

  def store_for_order(isbn)
    session[:items].nil? ? session[:items] = {} : 0
    max_copies = book_copies_in_store(isbn)
    session[:items][isbn] = 0 if session[:items][isbn].nil?
    session[:items][isbn] += 1 if available_copies(session[:items],isbn) > 0
  end

  def remove_from_order(isbn)
    unless session[:items].nil?
      session[:items][isbn].nil? ? 0 : temp_val = session[:items][isbn]
      temp_val > 0 ? session[:items][isbn] -= 1 : 0
    end
  end

  def ordered_copies(order_hash, book)
    order_hash[book].nil? ? 0 : order_hash[book]
  end

  def available_copies(order_hash, book)
    max_copies = book_copies_in_store book
    ordered = ordered_copies(order_hash, book)
    max_copies - ordered
  end

  def populate_order_list
    book_list = []
    unless session[:items].nil?
      unless session[:items].keys.empty?
        session[:items].each do |isbn, copies|
          if copies !=0 
            book = find_book_by isbn
            temp = []
            temp << book
            temp << copies
            book_list << temp
          end
        end
      end
    end
    book_list
  end

end
