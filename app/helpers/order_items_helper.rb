module OrderItemsHelper

  def book_in_order? (isbn)
    !(session[:items].nil?) ? (session[:items].include? isbn) : false
  end

end