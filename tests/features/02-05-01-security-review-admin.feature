Feature: Security Review admin pages
  As an admin user
  I want to run and configure Security Review
  So that I get a periodic audit of common Drupal security misconfigurations

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the Security Review report
    When I navigate to "/admin/reports/security-review"
    Then I should see "Security Review"

  Scenario: Admin can open the Security Review settings page
    When I navigate to "/admin/config/security-review"
    Then I should see "Security Review"
     And the "Save configuration" button should be visible

  Scenario: Security Review settings expose the untrusted roles fieldset
    When I navigate to "/admin/config/security-review"
    Then I should see "Untrusted roles"
