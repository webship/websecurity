Feature: Honeypot admin pages
  As an admin user
  I want to manage the Honeypot anti-spam settings
  So that login, register, password and webform submissions are protected
  against automated bots

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Honeypot configuration page
    When I navigate to "/admin/config/content/honeypot"
    Then I should see "Honeypot configuration"
     And the "Save configuration" button should be visible

  Scenario: Honeypot defaults from the recipe are applied
    When I navigate to "/admin/config/content/honeypot"
    Then I should see "Log blocked form submissions"
     And I should see "Honeypot element name"
     And I should see "Honeypot time limit"
