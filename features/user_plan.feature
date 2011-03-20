Feature: User membership plan
  In order to bill users appropriately
  As a administrator
  I want to present users with different options for consuming services

  Scenario: New user account created
    When a user creates a new account
    Then a new plan should be created for them

  Scenario: User receives monthly plan summary
    Given a valid user account
    Then at the end of the month the user should receive a summary of their account

  Scenario: User upgrades plan
    Given a user has a basic account
    When the user issues an upgrade request
    Then the user's plan should be a premium account
    And the user's monthly plan summary should reflect those changes