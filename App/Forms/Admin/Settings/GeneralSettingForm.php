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

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\FormBuilderBlueprint;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\FormBuilderBlueprintInterface;

class GeneralSettingForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /** @var FormBuilderBlueprintInterface $blueprint */
    private FormBuilderBlueprintInterface $blueprint;

    /**
     * Main class constructor
     *
     * @param FormBuilderBlueprint $blueprint
     * @return void
     */
    public function __construct(FormBuilderBlueprint $blueprint)
    {
        $this->blueprint = $blueprint;
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
                $this->blueprint->text(
                    'site_name',
                    ['uk-form-large'],
                    $this->hasValue('site_name'),
                    false,
                    'Site Name'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->text(
                    'site_tagline',
                    ['uk-form-large'],
                    $this->hasValue('site_tagline'),
                    false,
                    'Tagline'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->text(
                    'site_email',
                    ['uk-form-large'],
                    $this->hasValue('site_email'),
                    false,
                    'Administration Email Address'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true, null, 'This address is used for admin purposes. If you change this, we will send you an email at your new address to confirm it. The new address will not become active until confirmed.')
            )
            ->add(
                $this->blueprint->text(
                    'site_keywords',
                    [],
                    $this->hasValue('site_keywords'),
                    false,
                    'Keywords'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->add(
                $this->blueprint->textarea(
                    'site_description',
                    ['uk-textarea'],
                    'site_description'
                ),
                $this->hasValue('site_description'),
                $this->blueprint->settings(false, null, false, null, true)
            )

            ->add(
                $this->blueprint->submit(
                    'general-setting',
                    ['uk-button', 'uk-button-primary'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
