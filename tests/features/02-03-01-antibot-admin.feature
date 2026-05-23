Feature: Antibot admin pages
  As an admin user
  I want to manage Antibot settings
  So that form submissions require JavaScript and a non-trivial mouse movement
  before being accepted

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Antibot settings page
    When I navigate to "/admin/config/user-interface/antibot"
    Then I should see "Antibot"
     And the "Save configuration" button should be visible

  Scenario: Antibot exposes the protected forms list
    When I navigate to "/admin/config/user-interface/antibot"
    Then I should see "Form IDs"
