Feature: Log in with an email address
  As a site user
  I want to log in with my email address or my username
  So that I don't need to remember my username

  Scenario: Authenticated user can log in with the email address
    Given I log in with the email address of the "Authenticated user" user
    Then I should see "authenticated_user"
     And I should see "Log out"

  Scenario: An access denied page shows the login form
    Given I am an anonymous user
    When I navigate to "/admin"
    Then "input[name='pass']" should be attached
     And the "Log in" button should be visible
