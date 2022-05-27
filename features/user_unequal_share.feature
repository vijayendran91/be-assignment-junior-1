Feature: Users shares expenses

Background: Users sign up
Given Following users sign up
  | fname   | lname     | email                 | password  |
  | vijay   | gopal     | vijay@gmail.com       | abcd12345 |
  | darshan | kumaran   | darshan@gmail.com     | abcd12345 |
  | chandhu | muthiah   | chandhu@gmail.com     | abcd12345 |
  | sara    | logi      | sara@gmail.com        | abcd12345 |
  | anantha | subramani | anantha@gmail.com     | abcd12345 |

Scenario: Users make an unequal expense
  Given User "vijay" pays bill with following details
    | amount | no_parts | paid_by         | description |
    | 1000.0   | 4      | vijay@gmail.com | Dinner      |
  And A shared expense is made as following
    | email            | share_perc |
    |darshan@gmail.com | 25         |
    |chandhu@gmail.com | 25         |
    |sara@gmail.com    | 25         |
  And User "vijay@gmail.com" has the following in his dashboard
    | total_owe |  total_owed  |
    | 0.0       | 250.0        |
  And User "darshan@gmail.com" has the following in his dashboard
    | total_owe |  total_owed  |
    | 250.0       | 0.0        |
  And User "chandhu@gmail.com" has the following in his dashboard
    | total_owe |  total_owed  |
    | 250.0       | 0.0        |
  And User "sara@gmail.com" has the following in his dashboard
    | total_owe |  total_owed  |
    | 250.0       | 0.0        |


  Scenario: Users make an unequal expense
    Given User "vijay" pays bill with following details
      | amount    | no_parts | paid_by         | description |
      | 1000.0    | 4     | vijay@gmail.com | Dinner      |
    And A shared expense is made as following
      | email            | share_perc |
      |darshan@gmail.com | 30         |
      |chandhu@gmail.com | 20         |
      |sara@gmail.com    | 10         |
    And User "vijay@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 0.0       | 400.0        |
    And User "darshan@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 300.0       | 0.0        |
    And User "chandhu@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 200.0       | 0.0        |
    And User "sara@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 100.0       | 0.0        |

  Scenario: Users make more than one unequal expense
    Given User "vijay" pays bill with following details
      | amount    | no_parts | paid_by         | description |
      | 1000.0    | 4     | vijay@gmail.com | Dinner      |
    And A shared expense is made as following
      | email            | share_perc |
      |darshan@gmail.com | 30         |
      |chandhu@gmail.com | 20         |
      |sara@gmail.com    | 10         |
    And User "vijay@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 357.0       | 400.0        |
    And User "darshan@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 300.0       | 0.0        |
    And User "chandhu@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 200.0       | 0.0        |
    And User "sara@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 100.0       | 0.0        |
    Given User "vijay" pays bill with following details
      | amount    | no_parts | paid_by           | description |
      | 1190.0    | 3        | anantha@gmail.com | Dinner      |
    And A shared expense is made as following
      | email            | share_perc |
      |darshan@gmail.com | 60         |
      |vijay@gmail.com   | 30         |
    And User "vijay@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 357.0       | 400.0        |
    And User "darshan@gmail.com" has the following in his dashboard
      | total_owe |  total_owed  |
      | 1014.0    | 0.0        |
