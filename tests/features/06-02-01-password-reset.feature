Feature: Password reset is rate-limited and accepts the standard form
  As a site visitor
  I want to request a new password through the password reset form
  So that I can recover access to my account

  Scenario: Anonymous user can open the password reset form
    Given I am an anonymous user
    When I navigate to "/user/password"
    Then I should see "Username or email address"
     And the "Submit" button should be visible

  Scenario: Password reset form for an unknown account reports a generic message
    Given I am an anonymous user
    When I navigate to "/user/password"
    Then "input[name='url']" should be attached
