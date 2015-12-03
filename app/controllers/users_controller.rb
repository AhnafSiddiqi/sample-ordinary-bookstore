class UsersController < ApplicationController 

  def show
    @user = User.find_by(params[:login_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # if @user.save
    #   # Handle what happens
    #   render 'new'
    # else
    #   render 'new'
    # end
    flash.now[:success] = "You signed up successfully"
    render 'new'
  end

  def destroy
  end

  private 
    def user_params
      params.require(:user).permit(:login_id, :password)
    end
end
