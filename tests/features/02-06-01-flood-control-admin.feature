Feature: Flood control admin pages
  As an admin user
  I want to tune user-login and IP flood thresholds
  So that brute-force login attempts are throttled

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Flood control settings page
    When I navigate to "/admin/config/people/flood-control"
    Then I should see "Flood control"
     And the "Save configuration" button should be visible

  Scenario: Flood control defaults from the recipe are applied
    When I navigate to "/admin/config/people/flood-control"
    Then I should see "User Login"
