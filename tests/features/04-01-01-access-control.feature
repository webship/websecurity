Feature: Access control for security admin pages
  As a site administrator
  I want security admin pages to be protected
  So that only privileged users can change security configuration

  Scenario: Anonymous user cannot access the Honeypot config
    Given I am an anonymous user
    When I navigate to "/admin/config/content/honeypot"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Antibot config
    Given I am an anonymous user
    When I navigate to "/admin/config/user-interface/antibot"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Security Kit config
    Given I am an anonymous user
    When I navigate to "/admin/config/system/seckit"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Security Review report
    Given I am an anonymous user
    When I navigate to "/admin/reports/security-review"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Security Review settings
    Given I am an anonymous user
    When I navigate to "/admin/config/security-review"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Flood control config
    Given I am an anonymous user
    When I navigate to "/admin/config/people/flood-control"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the reCAPTCHA v3 config
    Given I am an anonymous user
    When I navigate to "/admin/config/people/captcha/recaptcha-v3"
    Then I should see "Access denied"

  Scenario: Anonymous user cannot access the Klaro config
    Given I am an anonymous user
    When I navigate to "/admin/config/user-interface/klaro"
    Then I should see "Access denied"

  Scenario: Authenticated user cannot access the Security Kit config
    Given I am a logged in user with the "Authenticated user" user
    When I navigate to "/admin/config/system/seckit"
    Then I should see "Access denied"

  Scenario: Authenticated user cannot access the Security Review settings
    Given I am a logged in user with the "Authenticated user" user
    When I navigate to "/admin/config/security-review"
    Then I should see "Access denied"
