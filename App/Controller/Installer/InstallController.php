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

namespace App\Controller\Installer;

use App\Controller\Installer\Form\ServerForm;
use App\Middleware\Before\HasEnv;
use App\Repository\InstallRepository;
use JetBrains\PhpStorm\ArrayShape;
use MagmaCore\Base\BaseController;
use MagmaCore\Utility\Sanitizer;

class InstallController extends BaseController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->diContainer(
            [
                'repository' => InstallRepository::class,
                'serverForm' => ServerForm::class,
            ]
        );
    }

    /**
     * Middleware which are executed before any action methods is called
     * middlewares are return within an array as either key/value pair. Note
     * array keys should represent the name of the actual class its loading ie
     * upper camel case for array keys. alternatively array can be defined as
     * an index array omitting the key entirely
     *
     * @return array
     */
    #[ArrayShape(['hasEnv' => "string"])] protected function callBeforeMiddlewares(): array
    {
        return [
            'hasEnv' => HasEnv::class
        ];
    }

    /**
     * Middleware which are executed before any action methods is called
     * middlewares are return within an array as either key/value pair. Note
     * array keys should represent the name of the actual class its loading ie
     * upper camel case for array keys. alternatively array can be defined as
     * an index array omitting the key entirely
     *
     * @return array
     */
    protected function callAfterMiddlewares(): array
    {
        return [
        ];
    }


    public function indexAction()
    {
        $this->render('client/install/index.html.twig',
            [
                'form' => $this->serverForm->createForm('/installer/install/step-one-process')
            ]
        );
    }


    protected function stepOneProcessAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('step-one-process-install')) {
                if ($this->formBuilder->csrfValidate()) {
                    $cleanData = Sanitizer::clean($this->formBuilder->getData());
                    $action = $this->repository->validateBeforeCreateConfig($cleanData)->create();
                    if ($this->error) {
                        $this->error->addError($this->repository->getErrors(), $this)->dispatchError();
                    }
                    if ($action) {

                    }
                }
            }
        endif;
    }

}