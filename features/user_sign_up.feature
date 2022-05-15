Feature: User Sign Up

Scenario: User Successful Sign Up
  Given User signs up with email "abc@abc.com" and password "abc12345"

Scenario: User unsuccessful with wrong email format
  Given User signs up with email "abcabc.com" and password "abc12345"
  Then User sees error "InvalidEmailError"

Scenario: User unsuccessful with wrong password format
  Given User signs up with email "abc@abc.com" and password "abc"
  Then User sees error "InvalidCredentialsError"
