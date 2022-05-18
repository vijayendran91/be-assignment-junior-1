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
    Given User "vijay" pays bill with following details
      | amount | no_parts | paid_by         | description |
      | 1000.0   | 5        | vijay@gmail.com | Dinner      |
    Given Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | chandhu@gmail.com |
      | sara@gmail.com    |
      | anantha@gmail.com |

  Scenario: User pays a bill for 5 participants
    Given Following expenses are reflected to the users
      | amount    | participant        |
      | -200.0     | darshan@gmail.com  |
      | -200.0     | chandhu@gmail.com  |
      | -200.0     | sara@gmail.com     |
      | -200.0     | anantha@gmail.com  |

  Scenario: Two different expenses involving a single user
    And User "anantha" pays bill with following details
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
      |   700.0   | vijay@gmail.com    |
      | -300.0    | sara@gmail.com     |

  Scenario: Listing all expenses of a user
    Then User "anantha@gmail.com" has the following expenses
      |borrower         | borrowed_from     |   amount    |
      |anantha@gmail.com| vijay@gmail.com   |   200.0     |
    And User "anantha" pays bill with following details
      | amount | no_parts | paid_by           | description |
      | 400.0  | 4        | anantha@gmail.com | Dinner      |
    And Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | vijay@gmail.com   |
      | sara@gmail.com    |
    Then User "anantha@gmail.com" has the following expenses
      |     borrower      | borrowed_from       |   amount    |
      |anantha@gmail.com| vijay@gmail.com       |   200.0     |
      | darshan@gmail.com | anantha@gmail.com   |   100.0     |
      | vijay@gmail.com   | anantha@gmail.com   |   100.0     |
      | sara@gmail.com    | anantha@gmail.com   |   100.0     |


  Scenario: Listing all expenses of a user after few settlements
    Then User "anantha@gmail.com" has the following expenses
      |borrower         | borrowed_from     |   amount    |
      |anantha@gmail.com| vijay@gmail.com   |   200.0     |
    And User "anantha" pays bill with following details
      | amount | no_parts | paid_by           | description |
      | 400.0  | 4        | anantha@gmail.com | Dinner      |
    And Expenses are added for the following people
      | participants      |
      | darshan@gmail.com |
      | vijay@gmail.com   |
      | sara@gmail.com    |
    Then User "anantha@gmail.com" has the following expenses
      |     borrower      | borrowed_from       |   amount    |
      |anantha@gmail.com  | vijay@gmail.com     |   200.0     |
      | darshan@gmail.com | anantha@gmail.com   |   100.0     |
      | vijay@gmail.com   | anantha@gmail.com   |   100.0     |
      | sara@gmail.com    | anantha@gmail.com   |   100.0     |
    And User "anantha@gmail.com" settles the following expense
      | borrowed_from   | amount |
      | vijay@gmail.com | 200    |
    Given Following "is not" the expense between user "vijay" and "anantha"
      | borrowed_from     | borrower         | amount   |
      | vijay@gmail.com   | anantha@gmail.com| 200.0    |
    Then User "anantha@gmail.com" has the following expenses
      |     borrower      | borrowed_from       |   amount    |
      | darshan@gmail.com | anantha@gmail.com   |   100.0     |
      | vijay@gmail.com   | anantha@gmail.com   |   100.0     |
      | sara@gmail.com    | anantha@gmail.com   |   100.0     |
