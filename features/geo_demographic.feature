Feature: Find Geo-Demographic Information
  In order to easily supply demographic information to our api users
  Users should be able to retrieve demographic information easily

  Scenario: Passing location IP
    When I execute a request for geo-demographic data based on IP '10.13.135.34'
    Then I should receive geo-demographic data

#  Scenario: Find by IP Address
#    Given '10.13.135.34'
#    When I restfully request geo-demographic data
#    Then I should receive geo-demographic data
#
#  Scenario: Account usage increments
#    Given a user a basic account has made X requests
#    When the user issues the next request
#    Then the user is shown a 402 error page
#    And the page has a link to account management



#todo add in an outline of values and responses to the geo requests

#todo add in seed for testing based on the ohio file in project

#todo: we should be getting back data that looks like ???

#todo: for bonus add in the client specification for columns