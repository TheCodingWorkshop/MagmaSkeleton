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

class DatetimeSettingForm extends ClientFormBuilder implements ClientFormBuilderInterface
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

    private function getDate(string $format)
    {
        return date($format) . ' (' . $format . ')';
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
                $this->blueprint->radio(
                    'date_format',
                    [],
                    $this->hasValue('date_format'),
                    false,
                    'Date Format'
                ),
                $this->blueprint->choices(
                    [
                        'j F Y' => $this->getDate('j F Y'),
                        'Y-m-d' => $this->getDate('Y-m-d'),
                        'm/d/Y' => $this->getDate('m/d/Y'),
                        'd/m/Y' => $this->getDate('d/m/Y')
                    ],
                    'j F Y'
                ),
                $this->blueprint->settings(false, null, true, null, true)
            )

            ->add(
                $this->blueprint->submit(
                    $this->hasValue('settings_id') ? 'edit-settings' : 'new-settings',
                    ['uk-button', 'uk-button-primary'],
                    'Save'
                ),
                null,
                $this->blueprint->settings(false, null, false, null, true)
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
