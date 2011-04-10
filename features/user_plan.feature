Feature: User membership plan
  In order to bill users appropriately
  As a administrator
  I want to present users with different options for consuming services

  Scenario: New user account created
    When a user creates a new account
    Then a new plan should be created for them

#  Scenario: User receives monthly plan summary
#    Given a valid user account
#    Then at the end of the month the user should receive a summary of their account

#  Scenario: User upgrades plan
#    Given I am a logged in user with a basic account
#    And I am on the edit account page
#    When I select the 'paid' plan
#    And I select the 'update' button
#    Then I should have a premium plan
    
#  Scenario: User upgrades plan
#    Given I am a logged in user with a premium account
#    And I am on the edit account page
#    When I select the 'basic' plan
#    And I select the 'update' button
#    Then I should have a basic plan

