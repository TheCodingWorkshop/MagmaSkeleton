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

namespace App\Forms\Admin\Role;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\TextType;
use MagmaCore\FormBuilder\Type\TextareaType;
use MagmaCore\FormBuilder\Type\SubmitType;
use MagmaCore\Auth\Model\RoleModel;

class RoleForm extends ClientFormBuilder implements ClientFormBuilderInterface
{


    /**
     * {@inheritdoc}
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "roleForm"])
            ->add(
                [TextType::class => [
                    'name' => 'role_name',
                    'class' => ['uk-input', 'uk-form-width-large'],
                ]]
            )
            ->add(
                [TextareaType::class => [
                    'name' => 'role_description',
                    'class' => ['uk-textarea', 'uk-form-width-large'],
                ]]
            )
            ->add(
                [SubmitType::class => [
                    'name' => empty($id) ? 'new-role' : 'edit-role',
                    'value' => 'Save',
                    'class' => ['uk-button uk-button-primary'],
                ]],
                null,
                ['show_label' => false, 'before_after_wrapper' => true]
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
