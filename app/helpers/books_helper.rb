module BooksHelper
  
  def copies_available?(isbn)
    if !(session[:items].nil?) && !(session[:items][isbn].nil?)
      max_copies = book_copies_in_store(isbn)
      session[:items][isbn] <= max_copies ? true : false
    else
      return true
    end
  end

  def book_search(search_params)
    search = strip_params search_params
    sort = search["sorted"]
    sort === "Year" ? sort = "year_of_publication" : sort = "score"

    if search['title'].present? && !(search['authors'].present?) && !(search['publisher'].present?) && !(search['subject'].present?)
      column = "title"
      value = search['title']
      find_by_one_column column, value, sort

    elsif !(search['title'].present?) && (search['authors'].present?) && !(search['publisher'].present?) && !(search['subject'].present?)
      column = "authors"
      value = search['authors']
      find_by_one_column column, value, sort

    elsif !(search['title'].present?) && !(search['authors'].present?) && (search['publisher'].present?) && !(search['subject'].present?)
      column = "publisher"
      value = search['publisher']
      find_by_one_column column, value, sort

    elsif !(search['title'].present?) && !(search['authors'].present?) && !(search['publisher'].present?) && (search['subject'].present?)
      column = "subject"
      value = search['subject'] 
      find_by_one_column column, value, sort

    elsif (search['title'].present?) && (search['authors'].present?) && !(search['publisher'].present?) && !(search['subject'].present?)
      columns = ["title", "authors"]
      values = [search['title'], search['authors']]
      operator = search['conj_one']
      find_by_two_column columns, values, operator, sort

    elsif (search['title'].present?) && !(search['authors'].present?) && (search['publisher'].present?) && !(search['subject'].present?)
      columns = ["title", "publisher"]
      values = [search['title'], search['publisher']]
      operator =  search['conj_one']
      find_by_two_column columns, values, operator, sort

    elsif (search['title'].present?) && !(search['authors'].present?) && !(search['publisher'].present?) && (search['subject'].present?)
      columns = ["title", "subject"]
      values = [search['title'], search['subject']]
      operator = search['conj_one']
      find_by_two_column columns, values, operator, sort

    elsif !(search['title'].present?) && (search['authors'].present?) && (search['publisher'].present?) && !(search['subject'].present?)
      columns = ["authors", "publisher"]
      values = [search['authors'], search['publisher']]
      operator = search['conj_two']
      find_by_two_column columns, values, operator, sort

    elsif !(search['title'].present?) && (search['authors'].present?) && !(search['publisher'].present?) && (search['subject'].present?)
      columns = ["authors", "subject"]
      values = [search['authors'], search['subject']]
      operator = search['conj_two']
      find_by_two_column columns, values, operator, sort

    elsif !(search['title'].present?) && !(search['authors'].present?) && (search['publisher'].present?) && (search['subject'].present?)
      columns = ["publisher", "subject"]
      values = [search['publisher'], search['subject']]
      operator = search['conj_three']
      find_by_two_column columns, values, operator, sort

    elsif (search['title'].present?) && (search['authors'].present?) && (search['publisher'].present?) && !(search['subject'].present?)
      columns = ["title", "authors", "publisher"]
      values = [search['title'], search['authors'], search['publisher']]
      operators = [search['conj_one'], search['conj_two']]
      find_by_three_column columns, values, operators, sort

    elsif (search['title'].present?) && (search['authors'].present?) && !(search['publisher'].present?) && (search['subject'].present?)
      columns = ["title", "authors", "subject"]
      values = [search['title'], search['authors'], search['subject']]
      operators = [search['conj_one'], search['conj_two']]
      find_by_three_column columns, values, operators, sort

    elsif (search['title'].present?) && !(search['authors'].present?) && (search['publisher'].present?) && (search['subject'].present?)
      columns = ["title", "publisher", "subject"]
      values = [search['title'], search['publisher'], search['subject']]
      operators = [search['conj_one'], search['conj_three']]
      find_by_three_column columns, values, operators, sort

    elsif !(search['title'].present?) && (search['authors'].present?) && (search['publisher'].present?) && (search['subject'].present?)
      columns = ["authors", "publisher", "subject"]
      values =  [search['authors'], search['publisher'], search['subject']]
      operators = [search['conj_two'], search['conj_three']]
      find_by_three_column columns, values, operators, sort

    elsif (search['title'].present?) && (search['authors'].present?) && (search['publisher'].present?) && (search['subject'].present?)
      columns = ["title", "authors", "publisher", "subject"]
      values = [search['title'], search['authors'], search['publisher'], search['subject']]
      operators = [search['conj_one'], search['conj_two'], search['conj_three']]
      find_by_four_column columns, values, operators, sort

    else 
      find_all_sorted_by sort
    end

  end

  def strip_params(params)
    params.each do |key, value|
      params[key] = value.strip
    end 
    params
  end

end
