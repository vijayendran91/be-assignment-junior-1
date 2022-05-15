module UserHelper

  def validate_email(email)
    result = email =~ User::VALID_EMAIL_REGEX
    if(result.nil?)
      raise InvalidEmailError.new("Invalid email format. Please try again.")
    end
  end

end
