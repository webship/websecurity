Feature: Klaro cookie consent module is wired into the front-end
  As a site administrator
  I want the Klaro module to be installed and reachable
  So that visitors can later be presented with a configurable consent dialog
  once Klaro apps and purposes are added

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Klaro admin landing page is reachable
    When I navigate to "/admin/config/user-interface/klaro"
    Then I should see "Klaro"
     And the "Save configuration" button should be visible

  Scenario: Klaro Purposes admin page is reachable
    When I navigate to "/admin/config/user-interface/klaro/purposes"
    Then I should see "Purposes"
