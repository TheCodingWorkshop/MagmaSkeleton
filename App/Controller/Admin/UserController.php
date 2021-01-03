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
use LoaderError;
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
                "column" => \App\DataColumns\UserColumn::class
            ]
        );
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

        $repository = $this
        ->repository
        ->getRepo()
        ->findWithSearchAndPaging($this->request->handler(), $args);
        $tableData = $this->tableGrid->create($this->column, $repository)->table();
        $this->render(
            'admin/user/index.html.twig',
            [
                "controller" => $this->thisRouteController(),
                "table" => $tableData,
                "pagination" => $this->tableGrid->pagination(),
                //"total_records" => $this->tableGrid->totalRecords(),
                //"columns" => $this->tableGrid->getColumns(),
                "results" => $repository,
               /* "search_query" => $this
                    ->request
                    ->handler()
                    ->query
                    ->getAlnum($this->tableGetSettings('filter_by')),*/
                "help_block" => ""
            ] 
        );
    }

    public function newAction()
    {
        if (isset($this->form)) {
            if ($this->form->canHandleRequest() && $this->form->isSubmittable('new-' . $this->thisRouteController())) {
                if ($this->form->csrfValidate()) {

                    $submit = $this
                    ->repository
                    ->getRepo()
                    ->validateRepository()
                    ->persistAfterValidation();

                    if (!$submit) {
                        $this->flashMessage($this->locale('new_added'));
                        $this->redirect('/admin/user/new');
                    } else {
                        $this->flashMessage($this->locale('fail_submission'), $this->flashWarning());
                        $this->redirect('/admin/user/new');    
                    }

                }
            }
        }
        $this->render(
            "/admin/user/new.html.twig",
            [
                "form" => $this->formUser->createForm('/admin/user/new')
            ]
        );
    }

    /**
     * table settings for this entity. Stored in flat file database
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