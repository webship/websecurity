Feature: Security Kit admin pages
  As an admin user
  I want to manage Security Kit
  So that the site sends defensive HTTP security headers

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Security Kit settings page
    When I navigate to "/admin/config/system/seckit"
    Then I should see "Security Kit"
     And the "Save configuration" button should be visible

  Scenario: Security Kit shows the cross-site scripting fieldset
    When I navigate to "/admin/config/system/seckit"
    Then I should see "Cross-site scripting"
     And I should see "Clickjacking"
     And I should see "SSL/TLS"
