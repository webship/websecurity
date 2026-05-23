Feature: Klaro cookie consent admin pages
  As an admin user
  I want to manage Klaro
  So that the site can show a configurable cookie/consent dialog

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Klaro settings page
    When I navigate to "/admin/config/user-interface/klaro"
    Then I should see "Klaro"
     And the "Save configuration" button should be visible

  Scenario: Klaro exposes the Services overview tab
    When I navigate to "/admin/config/user-interface/klaro/services"
    Then I should see "Services"
