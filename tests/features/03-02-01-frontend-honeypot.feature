Feature: Honeypot front-end protection on anonymous-accessible forms
  As a site administrator
  I want anonymous-accessible forms to carry the Honeypot trap field
  So that naive bots fill it in and get blocked

  Scenario: Anonymous user sees the Honeypot trap field on the password reset form
    Given I am an anonymous user
    When I navigate to "/user/password"
    Then "input[name='url']" should be attached

