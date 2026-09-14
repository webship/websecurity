# Web Security

Most needed contributed modules and configurations to manage a secure website.

## What it includes

The `recipes/default` recipe, applied when the module is installed, sets up:

- **Anti-spam:** CAPTCHA with Friendly Captcha (local challenge endpoint),
  reCAPTCHA v3, Antibot and Honeypot on the login, registration, password
  reset and comment forms. Authenticated users skip these checks.
- **Authentication:** log in with an email address or a username, an access
  denied page that shows the login form, a return to the login page after
  logging out, and a simpler registration form (ECA models).
- **Hardening:** Security Kit headers, Flood control, login flood limits,
  Security Review checks and the Klaro consent manager.
