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

namespace App\Controller\Admin;

use App\Controller\Admin\AdminController;
use App\Entity\UserEntity;
use MagmaCore\Utility\Yaml;
use App\Event\FlashMessagesEvent;
use LoaderError;
use MagmaCore\Session\Flash\Flash;
use RuntimeError;
use SyntaxError;

class UserController extends AdminController
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
        /**
         * Dependencies are defined within a associative array like example below
         * [ userModel => \App\Model\UserModel::class ]. Where the key becomes the 
         * property for the userModel object like so $this->userModel->getRepo();
         */
        $this->container(
            [
                "repository" => \MagmaCore\Auth\Model\UserModel::class,
                "column" => \App\DataColumns\UserColumn::class,
                "formUser" => \App\Forms\Admin\User\UserForm::class,                
            ]
        );  

    }

    private function userRepository()
    {
        $repository = $this->repository->getRepo();
        if (null !== $repository) {
            return $repository;
        }
    }

    private function findUserOr404()
    {
        $repository = $this->userRepository()
        ->findAndReturn($this->thisRouteID())
        ->or404();

        return $repository;
    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is 
     * made.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function indexAction()
    { 
        $args = Yaml::file('controller')[$this->thisRouteController()];
        //$args['records_per_page'] = $this->tablegetSettings('records_per_page', $this->thisRouteController());
        //$args['filter_by'] = $this->tablegetSettings('filter_by', $this->thisRouteController());

        $repository = $this->userRepository()
        ->findWithSearchAndPaging($this->request->handler(), $args);
        $tableData = $this->tableGrid->create($this->column, $repository)->table();
        $this->render(
            'admin/user/index.html.twig',
            [
                "controller" => $this->thisRouteController(),
                "table" => $tableData,
                "pagination" => $this->tableGrid->pagination(),
                "total_records" => $this->tableGrid->totalRecords(),
                "columns" => $this->tableGrid->getColumns(),
                "results" => $repository,
                /*"search_query" => $this
                    ->request
                    ->handler()
                    ->query
                    ->getAlnum($this->tableGetSettings('filter_by')),*/
                "help_block" => ""
            ] 
        );
    }

    /**
     * The show action request displays singluar information about a user. This is a 
     * read only request. Information here cannot be editted.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function showAction()
    {
        $this->render('admin/user/show.html.twig',
            [
                "form" => "",
                "user" => $this->findUserOr404(),
                "help_block" => ""
            ]
        );
    }

    /**
     * The new action request. is responsible for creating a new user. By sending
     * post data to the relevant model. Which is turns sanitize and validate the the 
     * incoming data. An event will be dispatched when a new user is created.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function newAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('new-' . $this->thisRouteController())) {
                if ($this->formBuilder->csrfValidate()) {
                    
                    $action = $this->userRepository()
                    ->validateRepository(new UserEntity($this->formBuilder->getData()))
                    ->persistAfterValidation();
                    if ($this->eventDispatcher) {
                        $this->eventDispatcher->dispatch(new FlashMessagesEvent($action, $this), FlashMessagesEvent::NAME);
                    }    
                }
            }
        endif;
        $this->render(
            "/admin/user/new.html.twig",
            [
                "form" => $this->formUser->createForm('/admin/user/new'),
                "errors" => $this->userRepository()->getValidationErrors(),
            ]
        );
    }

    /**
     * The edit action request. is responsible for updating a user record within
     * the database. User data wille be sanitized and validated before upon re 
     * submitting new data. An event will be dispatched on this action
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function editAction()
    {   

        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest() && $this->formBuilder->isSubmittable('edit-' . $this->thisRouteController())) {
                if ($this->formBuilder->csrfValidate()) {
                    
                    $action = $this->userRepository()
                    ->validateRepository(new UserEntity($this->formBuilder->getData()), $this->findUserOr404())
                    ->saveAfterValidation(['id' => $this->thisRouteID()]);
                    if ($this->eventDispatcher) {
                        $this->eventDispatcher->dispatch(new FlashMessagesEvent($action, $this), FlashMessagesEvent::NAME);
                    }        
                }
            }
        endif;
        $this->render('/admin/user/edit.html.twig',
            [
                "form" => $this->formUser->createForm("/admin/user/{$this->thisRouteID()}/edit", $this->findUserOr404()),
                "errors" => $this->userRepository()->getValidationErrors(),
                "help_block" => "",
                "user" => $this->findUserOr404(),
                "total_records" => "",
                "controller" => $this->thisRouteController()
            ]
        );
    }

    /**
     * The delete action request. is responsible for deleting a single record from
     * the database. This method is not a submittable method hence why this check has
     * been omitted. This a simple click based action. which is triggered within the
     * datatable. An event will be dispatch by this action
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function deleteAction()
    {
        if (isset($this->formBuilder)) :
            if ($this->formBuilder->canHandleRequest()) :
                $action = $this->userRepository()
                ->findByIDAndDelete(['id' => $this->thisRouteID()]);
                
                if ($this->eventDispatcher) {
                    $this->eventDispatcher->dispatch(new FlashMessagesEvent($action, $this), FlashMessagesEvent::NAME);
                }
            endif;
        endif;
    }

    /**
     * The table settings insert action request. Simple adds per table related 
     * configurable data. This provides customizable settings for each datatable
     *
     * @return bool
     */
    public function tableSettingsInsertAction() : bool
    {
        $this->tableSettingsInit($this->thisRouteController());
        $this->flashMessage('Changes Saved!');
        $this->redirect('/admin/user/index');
        return true;
    }

    /**
     * table settings for updating this entity. Stored in flat file database
     *
     * @return boolean
     */
    public function tableSettingsUpdateAction() : bool
    {
        $this->tableSettingsUpdateInit($this->thisRouteController());
        $this->flashMessage('Settings Updated!');
        $this->redirect('/admin/user/index');
        return true;
    }

}