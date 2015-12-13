class ReviewRatingsController < ApplicationController
  def create
    if insert_review_rating_db(review_ratings_params)
      flash.now[:succes] = 'added rating successfully'
    else
      flash.now[:warning] = 'failed to add rating. Try again'
    end
    redirect_to book_path(review_ratings_params[:book_id])
  end

  private

  def review_ratings_params
    params.require(:review_rating).permit(:customer_id, :customer_id2, :book_id, :rating)
  end
end
