include SessionApplication
Given("User signs up with email {string} and password {string}") do |email, password|
  begin
    create_new_user({:email => email, :password => password})
  rescue => e
    @error = e
  end
end
