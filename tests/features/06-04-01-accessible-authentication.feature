Feature: Accessible authentication on the sign-in forms
  As a site visitor
  I want my browser or password manager to fill the sign-in forms
  So that I can log in without retyping a password or solving a puzzle

  Scenario: Password managers can fill the login form
    Given I am an anonymous user
    When I navigate to "/user/login"
    Then "#edit-name" should have attribute "autocomplete" with value "username"
     And "#edit-pass" should have attribute "autocomplete" with value "current-password"
     And the element "form" with the attribute "autocomplete" and the value "off" should not exist

  Scenario: The login form has no math challenge
    Given I am an anonymous user
    When I navigate to "/user/login"
    Then ".captcha-type-challenge--math" should not be attached
     And I should not see "Math question"

  Scenario: The password reset form has no math challenge
    Given I am an anonymous user
    When I navigate to "/user/password"
    Then "#edit-name" should have attribute "autocomplete" with value "username"
     And ".captcha-type-challenge--math" should not be attached
     And I should not see "Math question"

  Scenario: The registration form has no math challenge
    Given I am an anonymous user
    When I navigate to "/user/register"
    Then ".frc-captcha" should be attached
     And the element "form" with the attribute "autocomplete" and the value "off" should not exist
     And ".captcha-type-challenge--math" should not be attached
     And I should not see "Math question"

  Scenario: The reCAPTCHA v3 fallback challenge is Friendly Captcha
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/people/captcha/recaptcha-v3"
    Then "select[name='default_challenge']" should have value "friendlycaptcha/friendlycaptcha"
