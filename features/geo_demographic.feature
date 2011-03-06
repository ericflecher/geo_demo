Feature: Find Geo-Demographic Information
  In order to easily supply demographic information to our api users
  Users should be able to retrieve demographic information easily

  Scenario: Find by Zip Code
    Given '44017'
    When I restfully request geo-demographic data
    Then I should receive geo-demographic data