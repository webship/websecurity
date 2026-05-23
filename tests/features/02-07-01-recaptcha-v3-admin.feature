Feature: reCAPTCHA v3 admin pages
  As an admin user
  I want to manage reCAPTCHA v3 keys and actions
  So that low-friction bot scoring can guard forms

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Admin can open the reCAPTCHA v3 settings page
    When I navigate to "/admin/config/people/captcha/recaptcha-v3"
    Then I should see "reCAPTCHA v3"
     And the "Save configuration" button should be visible

  Scenario: reCAPTCHA v3 exposes the key configuration fields
    When I navigate to "/admin/config/people/captcha/recaptcha-v3"
    Then I should see "Site key"
     And I should see "Secret key"
