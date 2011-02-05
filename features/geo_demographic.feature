Feature: Find Geo-Demographic Information
  In order to easily supply demographic information to our api users
  Users should be able to retrieve demographic information

  Scenario: Find by Zip Code
    Given a zip_code
    When I restfully request geo-demographic data
    Then I should receive geo-demographic data