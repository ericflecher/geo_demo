Feature: The user should be able to manage their account on
  abstract identity.

Scenario: View the users current usage for the past 12 months
  Given I am a user with a basic account
    And I am on the edit account page
    When I select the 'basic' plan
    And I select the 'update' button
    Then I should have a basic plan
