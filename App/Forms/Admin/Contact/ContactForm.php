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

namespace App\Forms\Admin\Contact;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\TextType;
use MagmaCore\FormBuilder\Type\TextareaType;
use MagmaCore\FormBuilder\Type\SubmitType;

class ContactForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        return $this->form(['action' => $action, 'class' => ['uk-form-stacked'], "id" => "permissionForm"])
            ->add(
                [TextType::class => [
                    'name' => 'permission_name',
                    'class' => ['uk-input', 'uk-form-width-large'],
                    'value' => (empty($permission_name) ? '' : $permission_name)
                ]]
            )
            ->add(
                [TextareaType::class => [
                    'name' => 'permission_description',
                    'class' => ['uk-textarea', 'uk-form-width-large'],
                ]],
                (empty($permission_description) ? '' : $permission_description)
            )
            ->add(
                [SubmitType::class => [
                    'name' => empty($id) ? 'new-permission' : 'edit-permission',
                    'value' => 'Save',
                    'class' => ['uk-button uk-button-primary'],
                ]],
                null,
                ['show_label' => false, 'before_after_wrapper' => true]
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
