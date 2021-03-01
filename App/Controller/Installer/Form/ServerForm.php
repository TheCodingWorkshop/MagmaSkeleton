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

namespace App\Controller\Installer\Form;

use MagmaCore\FormBuilder\ClientFormBuilder;
use MagmaCore\FormBuilder\ClientFormBuilderInterface;
use MagmaCore\FormBuilder\Type\TextType;
use MagmaCore\FormBuilder\Type\PasswordType;
use MagmaCore\FormBuilder\Type\SubmitType;

class ServerForm extends ClientFormBuilder implements ClientFormBuilderInterface
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
        return $this->form(['action' => $action, 'class' => ['uk-form-horizontal'], "id" => "serverInstallation"])
            ->add(
                [TextType::class => [
                    'name' => 'db_host',
                    'class' => ['uk-input', 'uk-form-width-large'],
                    'value' => '127.0.0.1'
                ]],
                null,
                ['new_label' => 'Database Server host name or IP Address']
            )
            ->add(
                [TextType::class => [
                    'name' => 'db_name',
                    'class' => ['uk-input', 'uk-form-width-large'],
                    'value' => ''
                ]],
                null,
                ['new_label' => 'Name of database']
            )
            ->add(
                [TextType::class => [
                    'name' => 'db_user',
                    'class' => ['uk-input', 'uk-form-width-large'],
                    'value' => 'root'
                ]],
                null,
                ['new_label' => 'Database username', 'description' => 'test']
            )
            ->add(
                [PasswordType::class => [
                    'name' => 'db_password',
                    'class' => ['uk-input', 'uk-form-width-medium'],
                    'pattern' => false
                ]],
                null,
                ['new_label' => 'Database password']
            )
            ->add(
                [TextType::class => [
                    'name' => 'db_port',
                    'class' => ['uk-input', 'uk-form-width-small'],
                    'value' => '3306'
                ]],
                null,
                ['new_label' => 'Database Port']
            )
            ->add(
                [TextType::class => [
                    'name' => 'db_prefix',
                    'class' => ['uk-input', 'uk-form-width-small'],
                    'value' => ''
                ]],
                null,
                ['new_label' => 'Database Prefix']
            )
            ->add(
                [TextType::class => [
                    'name' => 'db_driver',
                    'class' => ['uk-input', 'uk-form-width-medium'],
                    'value' => 'mysql'
                ]],
                null,
                ['new_label' => 'Database Driver']
            )
            ->add(
                [SubmitType::class => [
                    'name' => 'step-one-process-install',
                    'value' => 'Continue',
                    'class' => ['uk-button uk-button-primary', 'uk-form-medium'],
                ]],
                null,
                ['show_label' => false, 'before_after_wrapper' => true]
            )
            ->build(['before' => '<div class="uk-margin">', 'after' => '</div>']);
    }
}
