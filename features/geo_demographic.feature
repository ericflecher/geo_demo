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
  | ip     | 75.39.84.107                  |
  | ll     | 41.3661111, -81.8544444                     |
  |address | berea, oh                   |
  
  Scenario: Requesting demographic data
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a bad request for geo-demographic data
    Then I should receive a status 400 message

  Scenario: api count updates when a user makes a request
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    When I execute a request for geo-demographic data based on "ip" "75.39.84.107"
    Then the user should have their api_request incremented by one

  Scenario: Requesting specific demographic data
    Given an authenticatable user with a "basic" plan
    And geodemographic data in the database
    And I have specified specific demographic variables I am interested in
    When I execute a request for geo-demographic data based on "address" "Berea city, Cuyahoga county, Ohio" with a filter
    Then I should receive geo-demographic data
    And I should only receive the demographic variables I requested
