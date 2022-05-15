Feature: User Sign In

Scenario: User Successful Sign In
  Given User signs up with email "abc@abc.com" and password "abc12345"
  Then User signs in with email "abc@abc.com" and password "abc12345"

Scenario: User Signs in with invalid password
  Given User signs up with email "abc@abc.com" and password "abc12345"
  And User signs in with email "abc@abc.com" and password "abc12346"
  Then User sees error "InvalidCredentialsError"

  Scenario: User Signs in with invalid email
    Given User signs up with email "abcabc.com" and password "abc12345"
    And User signs in with email "abc@abc.com" and password "abc12346"
    Then User sees error "InvalidCredentialsError"
