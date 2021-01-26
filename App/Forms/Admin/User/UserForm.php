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
use MagmaCore\FormBuilder\Type\EmailType;
use MagmaCore\FormBuilder\Type\RadioType;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\SubmitType;
use MagmaCore\Auth\Model\RoleModel;
use MagmaCore\DataObjectLayer\DataLayerTrait;

class UserForm extends ClientFormBuilder implements ClientFormBuilderInterface
{

    use DataLayerTrait;

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
        return $this->form(['action' => $action, 'class' => ['uk-form-horizontal'], "id" => "userForm"])
            ->add(
                [TextType::class => [
                    'name' => 'firstname',
                    'value' => empty($firstname) ? '' : $firstname,
                    'class' => ['uk-input', 'uk-form-width-large'],
                ]],
                null,
                ['inline_icon' => 'user', 'inline_flip_icon' => true]
            )
            ->add(
                [TextType::class => [
                    'name' => 'lastname',
                    'value' => empty($lastname) ? '' : $lastname,
                    'class' => ['uk-input', 'uk-form-width-large'],
                ]],
                null,
                ['inline_icon' => 'user', 'inline_flip_icon' => true]
            )
            ->add(
                [EmailType::class => [
                    'name' => 'email',
                    'value' => empty($email) ? '' : $email,
                    'class' => ['uk-input', 'uk-form-width-large'],
                    'required' => false,
                    'pattern' => false
                ]],
                null,
                ['inline_icon' => 'mail', 'inline_flip_icon' => true]

            )
            ->add(
                [PasswordType::class => [
                    'name' => 'password_hash',
                    'value' => '',
                    'class' => ['uk-input', 'uk-width-1-1'],
                    'autocomplete' => 'new-password',
                    'pattern' => false
                ]],
                null,
                ['inline_icon' => 'lock', 'inline_flip_icon' => true, 'new_label' => 'Password']
            )
            ->add(
                [RadioType::class => [
                'name' => 'roles'
                ]],
                [
                'choices' => $this->flattenArrayRecursive(
                    (new RoleModel())->getRepo()->findBy(['role_name'])
                ),
                'default' => 'Subscriber'
                ],
                ['inline_icon' => false, 'before_after_wrapper' => true]
                )
            ->add(
                [RadioType::class => [
                    'name' => 'status',
                    'value' => empty($status) ? '' : $status,
                ]],
                ['choices' => [
                    'pending', 'active', 'lock', 'trash',
                ], 'default' => 'pending'],
                ['inline_icon' => '', 'before_after_wrapper' => true]
            )
            ->add(
                [TextType::class => [
                    'name' => 'remote_addr',
                    'value' => empty($remote_addr) ? '' : $remote_addr,
                    'class' => ['uk-input', 'uk-form-width-small'],
                    'disabled' => true,
                ]],
                null,
                ['inline_icon' => false, 'new_label' => 'IP']
            )
            ->add(
                [SubmitType::class => [
                    'name' => empty($id) ? 'new-user' : 'edit-user',
                    'value' => 'Save',
                    'class' => ['uk-button uk-button-primary'],
                ]],
                null,
                ['show_label' => false, 'before_after_wrapper' => false]
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
