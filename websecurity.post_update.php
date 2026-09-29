<?php

/**
 * @file
 * Post update functions for Web Security.
 */

/**
 * Let password managers fill the sign-in forms and drop the math challenge.
 */
function websecurity_post_update_accessible_authentication(): string {
  $config_factory = \Drupal::configFactory();
  $changed = [];

  // Security Kit printed autocomplete="off" on the sign-in forms, which keeps
  // password managers from filling them.
  $seckit = $config_factory->getEditable('seckit.settings');
  if (!$seckit->isNew() && $seckit->get('seckit_various.disable_autocomplete') === TRUE) {
    $seckit->set('seckit_various.disable_autocomplete', FALSE)->save();
    $changed[] = 'seckit.settings';
  }

  // The math question is a cognitive test. Only the old default is replaced:
  // a site that chose another fallback challenge, or none, keeps it.
  $recaptcha = $config_factory->getEditable('recaptcha_v3.settings');
  if (!$recaptcha->isNew() && $recaptcha->get('default_challenge') === 'captcha/Math') {
    $challenge = \Drupal::moduleHandler()->moduleExists('friendlycaptcha') ? 'friendlycaptcha/friendlycaptcha' : '';
    $recaptcha->set('default_challenge', $challenge)->save();
    $changed[] = 'recaptcha_v3.settings';
  }

  if (!$changed) {
    return (string) t('The sign-in forms already allow password managers, and the fallback challenge is not the math question.');
  }
  return (string) t('Updated @names.', ['@names' => implode(', ', $changed)]);
}
