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

namespace App\Forms\Admin\User;

use Exception;
use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\RadioType;

class SettingsForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    /**
     * @param string $action
     * @param object|null $dataRepository
     * @param object|null $callingController
     * @return string
     * @throws Exception
     */
    public function createForm(string $action, ?object $dataRepository = null, ?object $callingController = null): string
    {
        if ($dataRepository != null) {
            $dataRepository = (array)$dataRepository;
            extract($dataRepository);
        }
        return $this->form(['action' => $action, 'class' => ['uk-form-horizontal'], "id" => "userForm"])
            ->add(
                [RadioType::class => [
                    'name' => 'search_by',
                    'class' => ['uk-radio', 'uk-form-width-large'],
                ]],
                ['choices' => [
                    'pending', 'active', 'lock', 'trash',
                ], 'default' => 'pending'],

            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
