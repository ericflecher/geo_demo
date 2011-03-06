Feature: User membership plan
  In order to bill users appropriately
  As a administrator
  I want to present users with different options for consuming services

  Scenario: New user account created
    When a user creates a new account
    Then a new plan should be created for them