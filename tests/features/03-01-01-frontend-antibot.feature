Feature: Antibot front-end protection on the user login form
  As a site administrator
  I want the user login form to be protected by Antibot
  So that automated bots cannot submit the form without JavaScript

  Scenario: Anonymous user sees the Antibot noscript block on the login page
    Given I am an anonymous user
    When I navigate to "/user/login"
    Then "noscript" should be attached
     And the response body of "/user/login" should contain "antibot"
