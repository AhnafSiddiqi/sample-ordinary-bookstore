module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.login_id)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, class: 'gravatar')
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
    query = 'SELECT id FROM users WHERE id = (SELECT max(id) FROM users)'
    user_list = User.find_by_sql(query)
    user = user_list[0]
    customer = Customer.new(id: user.id)
    insert_customer_db(user) if customer.valid?
  end

  def current_customer_id
    current_user.id
  end

  def current_customer
    customer_id = current_user.id
    query = "Select * from customers where id = #{customer_id}"
    customer = Customer.find_by_sql(query)[0]
  end

  def create_store_manager
    query = 'SELECT id FROM users WHERE id = 1'
    user = User.find_by_sql(query)[0]
    store_manager = StoreManager.new(id: user.id)
    insert_store_manager_db(user) if store_manager.valid?
  end

  def user_type
    if current_user.id != 1
      'customer'
    else
      'manager'
    end
  end
end
