'use strict';

// Custom steps for the Web Security suite.
//
// Everything that resembles "I should see a field / button / element"
// has been intentionally removed — webship-js already ships those:
//
//   Then the field "Email" should exist        (field.steps.js)
//   Then the "Save" button should be visible   (web-first.steps.js)
//   Then "input[name='url']" should be visible (web-first.steps.js)
//
// Reach for the built-ins first. Only add a step here when no built-in
// covers the case.

const { Given, Then, When } = require('@cucumber/cucumber');
const {
  smartSettle,
  gotoUrl,
  fillField,
  friendly,
} = require('webship-js/tests/step-definitions/webship');

// ---------------------------------------------------------------------------
// Anti-bot timing helpers
// ---------------------------------------------------------------------------
// The Web Security recipe enables Antibot AND Honeypot on the user-login,
// password-reset, user-register, and admin/people/create forms.
//
//   * Antibot only fetches its session key after a mouse / scroll / touch
//     event. Headless Playwright never moves the mouse on its own, so we
//     dispatch a tiny mousemove before submission.
//   * Honeypot's recipe default is `time_limit: 2` — any submission less
//     than 2 seconds after page load is silently rejected. We sleep 3 s
//     to leave headroom.
//
// Both protections fail silently — the form just renders again as if the
// user mistyped. Without these helpers the whole login-dependent suite
// fails with "Access denied" or 5 s body-text timeouts and the cause is
// hard to spot.
async function satisfyAntibotAndHoneypot(page) {
  await page.mouse.move(100, 100);
  await page.mouse.move(200, 200);
  await page.waitForTimeout(3000);
}

/**
 * Log in as a named test user defined in cucumber.js worldParameters.users.
 *
 * The Webmaster row is the site-install super-admin. Every other row is
 * provisioned by `Given I add testing users` (see below).
 *
 * Example #1: Given I am a logged in user with the "Webmaster" user
 * Example #2: Given I am a logged in user with the "Content editor" user
 * Example #3: Given I am a logged in user with the "Authenticated user" user
 */
Given(/^I am a logged in user with( the)*( username)* "([^"]*)?"( user)?$/, async function (theCase, usernameCase, key, userCase) {
  const users = this.parameters.users || {};
  if (!(key in users)) {
    throw friendly(`No user named "${key}" in cucumber.js worldParameters.users`);
  }
  const { username, password } = users[key];
  if (!username || !password) {
    throw friendly(`User "${key}" is missing username or password in worldParameters.users`);
  }
  await gotoUrl(this.page, `${this.parameters.launchUrl}/user/login`);
  await smartSettle(this.page);
  await fillField(this.page, 'Username', username);
  await fillField(this.page, 'Password', password);
  await satisfyAntibotAndHoneypot(this.page);
  await this.page.getByRole('button', { name: 'Log in' }).click();
  await smartSettle(this.page);
});

/**
 * Provision every non-admin user from cucumber.js worldParameters.users.
 *
 * Example #1: Given I add testing users
 * Example #2: And I add the testing users
 */
Given(/^(?:I |we )?add( the)? testing users$/, async function (theCase) {
  const users = this.parameters.users || {};
  for (const [key, info] of Object.entries(users)) {
    if (info.isAdmin) continue;
    if (!info.username || !info.email || !info.password) {
      throw friendly(`User "${key}" is missing username/email/password in worldParameters.users`);
    }
    await gotoUrl(this.page, `${this.parameters.launchUrl}/admin/people/create`);
    await smartSettle(this.page);
    await fillField(this.page, 'name', info.username);
    await fillField(this.page, 'mail', info.email);
    await fillField(this.page, 'pass[pass1]', info.password);
    await fillField(this.page, 'pass[pass2]', info.password);
    for (const role of info.roles || []) {
      const cb = this.page.locator(`input[name="roles[${role}]"]`);
      if (await cb.count() > 0) await cb.check();
    }
    await satisfyAntibotAndHoneypot(this.page);
    await this.page.getByRole('button', { name: 'Create new account' }).click();
    await smartSettle(this.page);
  }
});

/**
 * Submit the standard user-login form with the given credentials.
 *
 * Example #1: When I attempt to log in as "badguy" with password "wrong"
 */
When(/^(?:I |we )?attempt to log in as "([^"]+)" with password "([^"]+)"$/, async function (username, password) {
  await gotoUrl(this.page, `${this.parameters.launchUrl}/user/login`);
  await smartSettle(this.page);
  await fillField(this.page, 'Username', username);
  await fillField(this.page, 'Password', password);
  await satisfyAntibotAndHoneypot(this.page);
  await this.page.getByRole('button', { name: 'Log in' }).click();
  await smartSettle(this.page);
});

// ---------------------------------------------------------------------------
// HTTP-level assertions
// ---------------------------------------------------------------------------
// These wrap `this.page.request` directly because they're cheaper than
// loading the whole page through the browser context — useful for
// sitemap / robots.txt / response-header style checks.

/**
 * Assert that the response of a path is the given HTTP status code.
 *
 * Example #1: Then the response status of "/admin/config/system/seckit" should be 200
 */
Then(/^the response status of "([^"]+)" should be (\d+)$/, async function (path, status) {
  const url = `${this.parameters.launchUrl}${path}`;
  const response = await this.page.request.get(url, { failOnStatusCode: false });
  const actual = response.status();
  if (String(actual) !== String(status)) {
    throw friendly(`Unexpected HTTP status for "${path}"`,
      new Error(`GET ${path} returned ${actual}, expected ${status}`));
  }
});

/**
 * Assert that the response body of a path contains a string.
 *
 * Example #1: Then the response body of "/robots.txt" should contain "User-agent:"
 */
Then(/^the response body of "([^"]+)" should contain "([^"]*)"$/, async function (path, needle) {
  const url = `${this.parameters.launchUrl}${path}`;
  const response = await this.page.request.get(url, { failOnStatusCode: false });
  const text = await response.text();
  if (!text.includes(needle)) {
    throw friendly(`Expected response body of "${path}" to contain "${needle}"`,
      new Error(`Response body of ${path} did not contain "${needle}"`));
  }
});

/**
 * Assert that a security HTTP response header is present on the front page.
 *
 * Example #1: Then the page response header "X-Content-Type-Options" should exist
 * Example #2: Then the page response header "X-Frame-Options" should exist
 */
Then(/^the page response header "([^"]+)" should exist$/, async function (headerName) {
  const response = await this.page.request.get(`${this.parameters.launchUrl}/`, { failOnStatusCode: false });
  const headers = response.headers();
  const lower = headerName.toLowerCase();
  if (!(lower in headers)) {
    throw friendly(`Expected response header "${headerName}" to be present on /`,
      new Error(`Got: ${Object.keys(headers).join(', ')}`));
  }
});

/**
 * Assert that a security HTTP response header equals a value.
 *
 * Example #1: Then the page response header "X-Content-Type-Options" should equal "nosniff"
 * Example #2: Then the page response header "X-Frame-Options" should equal "SAMEORIGIN"
 */
Then(/^the page response header "([^"]+)" should equal "([^"]*)"$/, async function (headerName, expected) {
  const response = await this.page.request.get(`${this.parameters.launchUrl}/`, { failOnStatusCode: false });
  const headers = response.headers();
  const lower = headerName.toLowerCase();
  if (!(lower in headers)) {
    throw friendly(`Unexpected value for header "${headerName}"`,
      new Error(`Response header "${headerName}" not present`));
  }
  if (headers[lower] !== expected) {
    throw friendly(`Unexpected value for header "${headerName}"`,
      new Error(`Was "${headers[lower]}", expected "${expected}"`));
  }
});
