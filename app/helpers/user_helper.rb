module UserHelper

  def validate_email(email)
    result = email =~ User::VALID_EMAIL_REGEX
    if(result.nil?)
      raise InvalidEmailError.new("Invalid email format. Please try again.")
    end
  end

  def is_borrower?(expense, user_id)
    if(expense[:borrower_id].to_s == user_id.to_s)
      return true
    end
  end
end
