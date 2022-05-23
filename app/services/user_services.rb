module UserServices
  def get_user_by_email_service(email)
    User.find_by(:email => email)
  end

  def create_new_user_service(params)
    user = User.new(params)
    user.save
    user
  end

  def get_user_by_id_service(user_id)
    User.find_by(:id => user_id)
  end

  def update_user_total_owe_service(user, amount)
    user.update_attribute(:total_owe, amount)
    user
  end

  def update_user_total_owed_service(user, amount)
    user.update_attribute(:total_owed, amount)
    user
  end

  def get_all_users_service
    User.all
  end

  def get_all_users_except_service(user_id)
    User.where.not(:id => user_id)
  end
end
