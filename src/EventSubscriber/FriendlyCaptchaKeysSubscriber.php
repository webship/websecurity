<?php

declare(strict_types=1);

namespace Drupal\websecurity\EventSubscriber;

use Drupal\Component\Utility\Crypt;
use Drupal\Core\Config\ConfigFactoryInterface;
use Drupal\Core\Recipe\RecipeAppliedEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

/**
 * Saves random Friendly Captcha keys when they are not set yet.
 *
 * The local API endpoint signs its puzzles with the site key, so each site
 * needs its own keys. Recipes install the module default settings with empty
 * keys, so the keys are saved once a recipe has been applied.
 */
final class FriendlyCaptchaKeysSubscriber implements EventSubscriberInterface {

  public function __construct(
    private readonly ConfigFactoryInterface $configFactory,
  ) {}

  /**
   * {@inheritdoc}
   */
  public static function getSubscribedEvents(): array {
    return [RecipeAppliedEvent::class => 'onRecipeApplied'];
  }

  /**
   * Saves the keys after a recipe has been applied.
   */
  public function onRecipeApplied(): void {
    $this->setKeys();
  }

  /**
   * Saves a random site key and API key when they are empty or placeholders.
   */
  public function setKeys(): void {
    $config = $this->configFactory->getEditable('friendlycaptcha.settings');
    if ($config->isNew()) {
      return;
    }
    $changed = FALSE;
    foreach (['site_key', 'api_key'] as $key) {
      $value = (string) $config->get($key);
      if ($value === '' || str_contains($value, '${')) {
        $config->set($key, Crypt::randomBytesBase64(32));
        $changed = TRUE;
      }
    }
    if ($changed) {
      $config->save();
    }
  }

}
