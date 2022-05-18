Feature: Add expenses to users

  Background: User signs up
    Given User signs up with email "abc@abc.com" and password "abc123456"
    Given Following users sign up
      | fname   | lname     | email                 | password  |
      | vijay   | gopal     | vijay@gmail.com       | abcd12345 |
      | darshan | kumaran   | darshan@gmail.com     | abcd12345 |
      | chandhu | muthiah   | chandhu@gmail.com     | abcd12345 |
      | sara    | logi      | sara@gmail.com        | abcd12345 |
      | anantha | subramani | anantha@gmail.com     | abcd12345 |


  Scenario: User pays a bill for 5 participants
    Given User "vijay" pays bill with following details
      | amount | no_parts | paid_by         | description |
      | 1000.0   | 5        | vijay@gmail.com | Dinner      |
    Given Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | chandhu@gmail.com |
      | sara@gmail.com    |
      | anantha@gmail.com |
      | vijay@gmail.com   |
    Given Following expenses are reflected to the users
      | amount    | participant        |
      | -200.0     | darshan@gmail.com  |
      | -200.0     | chandhu@gmail.com  |
      | -200.0     | sara@gmail.com     |
      | -200.0     | anantha@gmail.com  |

  Scenario: Two different expenses involving a single user
    Given User "vijay" pays bill with following details
      | amount | no_parts | paid_by         | description |
      | 1000.0   | 5        | vijay@gmail.com | Dinner      |
    Given Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | chandhu@gmail.com |
      | sara@gmail.com    |
      | anantha@gmail.com |
      | vijay@gmail.com   |
    Given Following expenses are reflected to the users
      | amount    | participant        |
      | -200.0     | darshan@gmail.com  |
      | -200.0     | chandhu@gmail.com  |
      | -200.0     | sara@gmail.com     |
      | -200.0     | anantha@gmail.com  |
    And User "vijay" pays bill with following details
      | amount | no_parts | paid_by           | description |
      | 400.0  | 4        | anantha@gmail.com | Dinner      |
    And Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | vijay@gmail.com   |
      | sara@gmail.com    |
    Given Following expenses are reflected to the users
      | amount    | participant        |
      | -300.0    | darshan@gmail.com  |
      |   900.0   | vijay@gmail.com    |
      | -300.0    | sara@gmail.com     |
