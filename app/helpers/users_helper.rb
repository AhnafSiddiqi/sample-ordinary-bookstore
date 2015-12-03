module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.login_id)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, class: "gravatar")
  end

  def params_hashify_password(params)
    params[:user][:password] = BCrypt::Password.create(params[:user][:password])
  end

end
