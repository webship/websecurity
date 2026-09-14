Feature: Anti-spam protection on the user registration form
  As a site administrator
  I want the registration form to carry Friendly Captcha and Honeypot
  So that bots cannot create accounts

  Scenario: Webmaster lets visitors create accounts
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/people/accounts"
     And I choose the radio button "input[name='user_register'][value='visitors']"
     And I press "Save configuration"
    Then I should see "The configuration options have been saved."

  Scenario: Anonymous user sees Friendly Captcha on the registration form
    Given I am an anonymous user
    When I navigate to "/user/register"
    Then ".frc-captcha" should be attached
     And "input[name='captcha_sid']" should be attached

  Scenario: Anonymous user sees the Honeypot trap field on the registration form
    Given I am an anonymous user
    When I navigate to "/user/register"
    Then "input[name='url']" should be attached
