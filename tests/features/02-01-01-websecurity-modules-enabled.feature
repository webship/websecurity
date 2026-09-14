Feature: Web Security bundled modules are enabled
  As an admin user
  I want to verify that the Web Security recipe enables every security module
  So that I know the recipe ran cleanly during install

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Modules report status page lists Web Security as enabled
    When I navigate to "/admin/modules"
    Then I should see "Web Security"
     And I should see "Antibot"
     And I should see "Flood control"
     And I should see "Honeypot"
     And I should see "Klaro"
     And I should see "reCAPTCHA v3"
     And I should see "Security Kit"
     And I should see "Security Review"
     And I should see "CAPTCHA"
     And I should see "Friendly Captcha"
     And I should see "Login with email or username"
     And I should see "ECA User"
