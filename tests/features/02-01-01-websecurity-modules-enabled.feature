Feature: Web Security bundled modules are enabled
  As an admin user
  I want to verify that the Web Security recipe enables every security module
  So that I know the recipe ran cleanly during install

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Modules report status page lists Web Security as enabled
    Then the "websecurity" module should be installed
     And the "antibot" module should be installed
     And the "flood_control" module should be installed
     And the "honeypot" module should be installed
     And the "klaro" module should be installed
     And the "recaptcha_v3" module should be installed
     And the "seckit" module should be installed
     And the "security_review" module should be installed
     And the "captcha" module should be installed
     And the "friendlycaptcha" module should be installed
     And the "login_emailusername" module should be installed
     And the "eca_user" module should be installed
