Feature: Find Geo-Demographic Information
  In order to easily supply demographic information to our api users
  Users should be able to retrieve demographic information easily

  Scenario: Passing location IP
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a request for geo-demographic data based on IP "76.190.225.221"
    Then I should receive geo-demographic data


#ACC - the above scenario is not working for me, once we get it fixed we need to move to this kind of structure:
#  Scenario Outline: Requesting demographic data
#    Given an authenticatable user with a "basic" plan
#    And geodemographic data in the database
#    When I execute a request for geo-demographic data based on <format> <data>
#    Then I should receive geo-demographic data
#
#  Scenarios:
#  | format | data                            |
#  | ip     | 76.190.225.221                  |
#  | ll     | 41.577899932861,81.193000793457 |


  Scenario: api count updates when a user makes a request
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a request for geo-demographic data based on IP "76.190.225.221"
    Then the user should have their api_request incremented by one

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
