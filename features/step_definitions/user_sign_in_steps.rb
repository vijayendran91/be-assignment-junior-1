include SessionApplication
And("User signs in with email {string} and password {string}") do |email, password|
  begin
    user_sign_in({:email => email, :password => password})
  rescue => @error
  end
end

Then("User sees error {string}") do |error|
  @error.class.to_s.should == error
end

And("Session is created for the same user {string}") do |email|
  user = get_user_by_email(email)
  session[:user_id].should == user[:id]
end
