Feature: Provide heroku addon functionality

  Scenario: Heroku Provisioning of Services
    When running the kensa provision test
    Then the test should run with no fails