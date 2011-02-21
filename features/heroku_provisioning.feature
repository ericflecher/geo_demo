Feature: Provide heroku addon functionality

  Scenario: Heroku Provisioning of Services
    Given the Heroku provisioning service is running
    When running the kensa provision test
    Then the test should run with no fails