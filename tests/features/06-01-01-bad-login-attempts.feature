Feature: Failed login attempts are rejected
  As a site administrator
  I want bogus login attempts to be rejected
  So that brute-force traffic does not gain access

  Scenario: Wrong password is rejected with the standard error message
    Given I am an anonymous user
    When I attempt to log in as "webmaster" with password "totally-wrong"
    Then I should see "Unrecognized username or password"
