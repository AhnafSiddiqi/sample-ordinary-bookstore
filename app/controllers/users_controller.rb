class UsersController < ApplicationController 

  def new
    @user = User.new
    render 'signup'
  end

  def create
    if password_confirmation (params)
      assign_hashed_password (params)
      @user = User.new(user_params)
      if @user.valid?
        byebug
        insert_user_db (params)
        create_customer
        flash.now[:success] = "You signed up successfully"
        redirect_to @user
      else
        render 'signup'
      end
    else 
      @user = User.new
      @user.errors.add(:password, "doesn't match!")
      render 'signup'
    end
  end

  def destroy
  end

  private 

    def user_params
      params.require(:user).permit(:login_id, :password)
    end

end
