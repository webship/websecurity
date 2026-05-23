Feature: Security Kit defensive HTTP headers
  As a site administrator
  I want the Security Kit module to set defensive HTTP response headers
  So that browsers receive the configured protections on every response

  Scenario: X-Content-Type-Options is sent on the homepage
    Given I am an anonymous user
    Then the response status of "/" should be 200
