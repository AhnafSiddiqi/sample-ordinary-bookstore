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
        insert_user_db (params)
        @user = User.last
        if @user.id == 1
          create_store_manager
        else
          create_customer
        end
        flash.now[:success] = 'You signed up successfully'
        render 'signup'
      else
        render 'signup'
      end
    else
      @user = User.new
      @user.errors.add(:password_digest, "doesn't match!")
      render 'signup'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:login_id, :password_digest)
  end
end
