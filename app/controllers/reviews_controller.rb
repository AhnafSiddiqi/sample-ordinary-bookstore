class ReviewsController < ApplicationController
  def new
    @review = Review.new(book: @book)
  end

  def create
    @review = Review.new
    params1 = review_params
    params1[:customer_id] = current_customer.id
    if insert_review_db(params1)
      flash.now[:success] = 'Added new review'
      redirect_to book_path(review_params[:book_id])
    else
      flash.now[:warning] = "Couldn't add the review. Try again"
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:score, :comment, :book_id, :review_date)
  end
end
