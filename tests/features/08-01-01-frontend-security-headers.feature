Feature: Security-related HTTP headers on the front-end
  As a site visitor
  I want the front-end to set defensive HTTP response headers
  So that browsers benefit from Drupal's and Security Kit's protections

  Scenario: Front-page response is 200 with Drupal-generator meta tag
    Given I am an anonymous user
    When I navigate to "/"
    Then the response status of "/" should be 200
     And the response body of "/" should contain "Drupal"

  Scenario: robots.txt is accessible to anonymous visitors
    Given I am an anonymous user
    Then the response status of "/robots.txt" should be 200
     And the response body of "/robots.txt" should contain "User-agent:"
