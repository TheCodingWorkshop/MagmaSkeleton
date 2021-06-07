<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace App\Forms\Admin\Settings;

use MagmaCore\Settings\Settings;
use MagmaCore\Utility\GravatarGenerator;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class AvatarSettingForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;
    private Settings $settings;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @return void
     */
    public function __construct(FormBuilderBlueprint $blueprint, Settings $settings)
    {
        $this->blueprint = $blueprint;
        $this->settings = $settings;
    }

    /**
     * {@inheritdoc}
     * @param string $action - form action
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, $dataRepository = null, object $callingController = null)
    {
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "tableForm"])
            ->addRepository($dataRepository)
            ->add(
                $this->blueprint->checkbox(
                    'show_gravatar',
                    ['uk-checkbox'],
                    $this->settings->get('show_gravatar'),
                ),
                null,
                $this->blueprint->settings(false, null, false, 'App ID', true, 'Enable Gravatar', 'This only affects the gravatar on the backend of the application and nowhere else.')
            )
            ->add(
                $this->blueprint->text(
                    'gravatar_size',
                    ['uk-form-large', 'uk-border-bottom', 'uk-form-blank', 'uk-width-1-4'],
                    $this->settings->get('gravatar_size'),
                    false,
                    'Gravatar Size'
                ),
                null,
                $this->blueprint->settings(false, null, false, 'App ID', true, null, 'Use to adjust the size of the gravatar. Note that this will affect all avatar within the backend of the application.')
            )
            ->add(
                $this->blueprint->radio(
                    'gravatar_rating',
                    ['uk-radio'],
                    'gravatar_rating',
                    $this->settings->get('gravatar_rating'),
                ),
                $this->blueprint->choices($this->gravatarRatings(), 'r'),
                $this->blueprint->settings(false, null, false, 'Gravatar Rating', true, null, '')
            )
            ->add(
                $this->blueprint->radio(
                    'gravatar_default',
                    ['uk-radio'],
                    'gravatar_default',
                    $this->settings->get('gravatar_default'),
                ),
                $this->blueprint->choices(
                    $this->gravatarDefault(), 
                    'mystery'
                ),
                $this->blueprint->settings(
                    false, 
                    null, 
                    false, 
                    'Gravatar Default', 
                    true, 
                    null, 
                    'For users without a custom avatar of their own, you can either display a generic logo or a generated one based on their email address. ' . $this->getSelectedAvatar())
            )
            ->add(
                $this->blueprint->submit(
                    'application-settings',
                    ['uk-button', 'uk-button-primary'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )

            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }

    private function gravatarRatings()
    {
        return [
            'g' => 'G - Suitable for all audience',
            'pg' => 'PG - Possibly offensive, usually for audiences 13 and above',
            'r' => 'R - Intended for adult audiences above 17',
            'x' => 'X - Even more mature than above'
        ];
    }

    private function gravatarDefault()
    {
        return [
            'blank' => 'blank',
            'mystery' => 'Mystery Person',
            'identicon' => 'Identicon',
            'monsterid' => 'Monsterid',
            'wavatar' => 'Wavatar',
            'retro' => 'Retroid'
        ];

    }

    private function getGravatarDefault()
    {
        return array_map(fn($ava) => '<img alt="" src="' . GravatarGenerator::getGravatar(
            $this->settings->get('site_email'),
            $ava,
            80
        ) .  '" />', $this->gravatarDefault());
    }

    private function getSelectedAvatar()
    {
        $size = 80;
        $grav_url = "https://www.gravatar.com/avatar/" . md5( strtolower( trim( $this->settings->get('site_email') ) ) ) . "?d=" . urlencode( $this->settings->get('gravatar_default') ) . "&s=" . $size;
        return '<div><img class="uk-img" alt="" src="' . $grav_url . '" /></div>';

    }

}
