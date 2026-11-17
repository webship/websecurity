Feature: Anti-spam protection on the user registration form
  As a site administrator
  I want the registration form to carry Friendly Captcha and Honeypot
  So that bots cannot create accounts

  The site build lets visitors create accounts (the Standard profile's
  "Visitors, but administrator approval is required"): the suite does not
  change the site's settings.

  Scenario: Visitors can open the registration form
    Given I am an anonymous user
    Then I should be allowed access to "/user/register"

  Scenario: Anonymous user sees Friendly Captcha on the registration form
    Given I am an anonymous user
    When I navigate to "/user/register"
    Then ".frc-captcha" should be attached
     And "input[name='captcha_sid']" should be attached

  Scenario: Anonymous user sees the Honeypot trap field on the registration form
    Given I am an anonymous user
    When I navigate to "/user/register"
    Then "input[name='url']" should be attached
