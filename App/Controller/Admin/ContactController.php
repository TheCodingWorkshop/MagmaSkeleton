<?php

declare(strict_types=1);

namespace App\Controller\Admin;

use App\Controller\Admin\AdminController;

class ContactController extends AdminController
{

    /**
     * Extends the base constructor method. Which gives us access to all the base
     * methods inplemented within the base controller class.
     * Class dependency can be loaded within the constructor by calling the
     * container method and passing in an associative array of dependency to use within
     * the class
     *
     * @param array $routeParams
     * @return void
     * @throws BaseInvalidArgumentException
     */
    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->diContainer(
            [
                'repository' => \App\Model\ContactModel::class,
                'column' => \App\DataColumns\ContactColumn::class,
                //'formContact' => \App\Forms\Admin\User\ContactForm::class,
            ]
        );

    }

    public function indexAction()
    {
        $this->indexAction
            ->execute($this, NULL, NULL, __METHOD__)
                ->render()
                    ->with()
                        ->table()
                            ->end();
    }

    protected function newAction()
    {


}