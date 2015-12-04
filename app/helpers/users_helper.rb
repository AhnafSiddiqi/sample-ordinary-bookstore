module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.login_id)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, class: "gravatar")
  end

  def password_confirmation(params)  
    password = params[:user][:password_digest]
    password_confirmation = params[:user][:password_confirmation]
    (password == password_confirmation) ? true : false
  end

  def assign_hashed_password(params)
    hashed_password = params_hashify_password (params)
    params[:user][:password_digest] = hashed_password
  end

  def params_hashify_password(params)
    BCrypt::Password.create(params[:user][:password_digest])
  end

  def create_customer
    query = "SELECT id FROM users WHERE id = (SELECT max(id) FROM users)"
    user_list = User.find_by_sql(query)
    user = user_list[0]
    customer = Customer.new(id: user.id)
    if customer.valid?
      insert_customer_db(user)
    end
  end

end
