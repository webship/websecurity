Feature: Security Review can be executed
  As a site administrator
  I want to run the Security Review checks
  So that I can inspect the report for misconfigurations

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Security Review settings expose the configured check list
    When I navigate to "/admin/config/security-review"
    Then I should see "Security Review"
     And I should see "Save configuration"

  Scenario: Security Review report page is reachable
    When I navigate to "/admin/reports/security-review"
    Then I should see "Security Review"
