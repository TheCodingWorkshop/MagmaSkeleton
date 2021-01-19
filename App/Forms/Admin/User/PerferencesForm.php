<?php
/*
 * This file is part of the MagmaCore package.
 *
 * (c) Ricardo Miller <ricardomiller@lava-studio.co.uk>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare (strict_types = 1);

namespace App\Forms\Admin\User;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\TextType;
use MagmaCore\FormBuilder\Type\SelectType;
use MagmaCore\FormBuilder\Type\RadioType;
use MagmaCore\FormBuilder\Type\FileType;
use MagmaCore\FormBuilder\Type\SubmitType;

class PerferencesForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /**
     * {@inheritdoc}
     *
     * @param string $action - form action
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, $dataRepository = null)
    {
        if ($dataRepository != null) {
            $dataRepository = (array) $dataRepository;
            extract($dataRepository);
        }
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "userForm"])
            ->add(
                [SelectType::class => [
                    'name' => 'languages',
                    'class' => ['uk-select', 'uk-form-width-large'],
                ]],
                null,
                ['description' => 'The language that the control panel should use.']
            )
            ->add(
                [SelectType::class => [
                    'name' => 'locale',
                    'class' => ['uk-select', 'uk-form-width-medium'],
                ]],
                null,
                ['description' => 'The locale that should be used for date and number formatting.']
            )
            ->add(
                [FileType::class => [
                    'name' => 'photo',
                    'class' => ['uk-upload', 'uk-form-width-medium'],
                ]],
            )

            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
