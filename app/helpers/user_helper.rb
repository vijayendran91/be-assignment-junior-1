module UserHelper

  def validate_email(email)
    result = email =~ User::VALID_EMAIL_REGEX
    if(email == "")
      raise InvalidEmailError.new("Please enter an email id to sign up!")
    elsif(result.nil?)
      raise InvalidEmailError.new("Invalid email format. Please try again.")
    end
  end

  def is_borrower?(expense, user_id)
    if(expense[:borrower_id].to_s == user_id.to_s)
      return true
    end
  end

  def validate_sign_up_params(params)
    if(params[:first_name] == "")
      raise UserSignUpError.new("Please enter your first name")
    elsif params[:last_name] == ""
      raise UserSignUpError.new("Please enter your last name")
    end
  end
end
