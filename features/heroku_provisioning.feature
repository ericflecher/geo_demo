Feature: Provide heroku addon functionality

  Scenario: Heroku Provisioning of Services
    When running the kensa provision "provision" test
    Then the test should run with no fails

  Scenario: Heroku Deprovisioning of Services
    Given an account
    And a "basic" plan
    When running the kensa deprovision "deprovision" test
    Then the test should run with no fails when deprovisioning
    And the user should not have a plan associated to them

  Scenario: Heroku Plan Change
    Given an account
    And a "basic" plan
    When running the kensa plan change "planchange" with plan "premium"
    Then the test should run with no fails
    And the user should have only a "premium" plan associated