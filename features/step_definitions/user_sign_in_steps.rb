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
