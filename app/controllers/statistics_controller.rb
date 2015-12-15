class StatisticsController < ApplicationController

  def index
    if (params[:m_books].present?)
      @popular_books = retrieve_m_popular_books(params[:m_books][:value])
      @popular_authors = retrieve_m_popular_authors(params[:m_books][:value])
      @popular_publishers = retrieve_m_popular_publishers(params[:m_books][:value])
    end
    render 'index'
  end

end
