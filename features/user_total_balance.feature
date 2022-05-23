Feature: User Looks at Dashboard; Total Balance quick load

Background:
  Given Following users sign up
    | fname   | lname     | email                 | password  |
    | vijay   | gopal     | vijay@gmail.com       | abcd12345 |
    | darshan | kumaran   | darshan@gmail.com     | abcd12345 |
    | chandhu | muthiah   | chandhu@gmail.com     | abcd12345 |
    | sara    | logi      | sara@gmail.com        | abcd12345 |
    | anantha | subramani | anantha@gmail.com     | abcd12345 |
  Given User "vijay" pays bill with following details
    | amount   | no_parts | paid_by         | description |
    | 1000.0   | 5        | vijay@gmail.com | Dinner      |
  Given Expenses are added for the following people
    | participants      |
    | darshan@gmail.com |
    | chandhu@gmail.com |
    | sara@gmail.com    |
    | anantha@gmail.com |

Scenario: User checks his total balance in dashboard
    And User "vijay@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 0.0       | 800.0        |
    And User "anantha" pays bill with following details
      | amount | no_parts | paid_by           | description |
      | 400.0  | 4        | anantha@gmail.com | Dinner      |
    And Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | vijay@gmail.com   |
      | sara@gmail.com    |
    And User "vijay@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 100.0     | 800.0        |
