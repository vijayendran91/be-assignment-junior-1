module UserServices
  def get_user_by_email_service(email)
    User.find_by(:email => email)
  end

  def create_new_user_service(params)
    user = User.new(params)
    user.save
    user
  end
end
