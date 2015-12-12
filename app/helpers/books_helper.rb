module BooksHelper

  def copies_available?(isbn)
    if !(session[:items].nil?) && !(session[:items][isbn].nil?)
      max_copies = book_copies_in_store(isbn)
      puts session[:items][isbn]
      session[:items][isbn] < max_copies ? true : false
    else 
      return true
    end
  end

end
