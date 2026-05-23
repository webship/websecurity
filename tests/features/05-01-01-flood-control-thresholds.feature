Feature: Flood control thresholds from the Web Security recipe
  As a site administrator
  I want the user/IP flood thresholds shipped by the recipe to be present
  So that brute-force login attempts hit the throttle quickly

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Recipe defaults for user_limit and ip_limit are present in config
    When I navigate to "/admin/config/people/flood-control"
    Then the response body of "/admin/config/people/flood-control" should contain "10"
     And the response body of "/admin/config/people/flood-control" should contain "8"
