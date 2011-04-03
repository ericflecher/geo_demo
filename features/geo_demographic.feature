Feature: Find Geo-Demographic Information
  In order to easily supply demographic information to our api users
  Users should be able to retrieve demographic information easily

  Scenario Outline: Requesting demographic data
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a request for geo-demographic data based on "<format>" "<data>"
    Then I should receive geo-demographic data

  Scenarios:
  | format | data                            |
  | ip     | 76.190.225.221                  |
  | ll     | 41.5, -81.1                     |
  |address | twinsburg, oh                   |
  
  Scenario: Requesting demographic data
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a bad request for geo-demographic data
    Then I should receive a status 400 message

  Scenario: api count updates when a user makes a request
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a request for geo-demographic data based on "ip" "76.190.225.221"
    Then the user should have their api_request incremented by one


#todo add in seed for testing based on the ohio file in project

#todo: we should be getting back data that looks like ???

#todo: for bonus add in the client specification for columns
