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

use MagmaCore\Base\BaseController;
use MagmaCore\Utility\Sanitizer;
use MagmaCore\Utility\Yaml;
use MagmaCore\Session\SessionTrait;

class AdminController extends BaseController
{

    use SessionTrait;

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
                "tableGrid" => \MagmaCore\Datatable\Datatable::class /* Global access */
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
    protected function callBeforeMiddlewares() : array
    {
        return [
            'AuthorizedIsNull' => \App\Middleware\Before\AuthorizedIsNull::class,
            'BasicAuthentication' => \App\Middleware\Before\BasicAuthentication::class,
            'AdminAuthentication' => \App\Middleware\Before\AdminAuthentication::class,
            'SessionExpires' => \App\Middleware\Before\SessionExpires::class
        ];
    }

    /**
     * After filter which is called after every controller. Can be used
     * for garbage collection
     *
     * @return array
     */
    protected function callAfterMiddlewares() : array
    {
        return [

        ];
    }

    private function tableOptions(string $autoController): array
    {
        $cleanData = Sanitizer::clean($_POST);
        $config = Yaml::file('controller')[$autoController];

        /* records per page */
        $recordsPerPage = (isset($cleanData['records_per_page']) ? $cleanData['records_per_page'] : $config['records_per_page']);
        /* column visibility */
        $columnVisible = (isset($cleanData['columns_visible']) ? $cleanData['columns_visible'] : []);
        /* filter by */
        $filterBy = (isset($cleanData['filter_by']) ? $cleanData['filter_by'] : $config['filter_by']);

        return [
            $recordsPerPage,
            $columnVisible,
            $filterBy
        ];
    }

    /**
     * Checks whether the entity settings is being called from the correct 
     * controller and return true. returns false otherwise
     *
     * @param string $autoController
     * @return boolean
     */
    private function isControllerValid(string $autoController): bool
    {
        if (is_array($this->routeParams) && in_array($autoController, $this->routeParams, true)) {
            if (isset($this->routeParams['controller']) && $this->routeParams['controller'] == $autoController) {
                return true;
            }
        }
        return false;
    }

    /**
     * Returns the current object controller as a string value
     *
     * @param string $controller
     * @return string
     */
    private function getCurrentController(string $controller): string
    {
        return ($controller != null) ? $controller : $this->thisRouteController();
    }

    /**
     * Allows each entity to be able to be customizable in terms of settings the amount
     * of table data to be displayd per page and change the search filter. These options 
     * can be customize from each entity page.
     *
     * @param string|null $controller
     * @return boolean
     */
    public function tableSettingsInit(?string $controller = null): bool
    {
        $autoController = $this->getCurrentController($controller);
        $this->channel = $autoController . 'Settings';

        if ($this->isControllerValid($autoController)) {
            list(
                $recordsPerPage,
                $columnVisible,
                $filterBy
            ) = $this->tableOptions($autoController);

            $fileData = [
                "id" => $autoController,
                "records_per_page" => $recordsPerPage,
                "columns_visible" => $columnVisible,
                "filter_by" => $filterBy
            ];

            $this->flatDb
                ->flatDatabase()
                ->insert()
                ->in($this->channel)
                ->set($fileData)
                ->execute();
            return true;
        }
        return false;
    }

    /**
     * Method which updates the entity page settings
     *
     * @param string|null $controller
     * @return void
     */
    public function tableSettingsUpdateInit(?string $controller = null)
    {
        $autoController = $this->getCurrentController($controller);
        if ($this->isControllerValid($autoController)) {
            list(
                $recordsPerPage,
                $columnVisible,
                $filterBy
            ) = $this->tableOptions($autoController);

            $fileData = [
                "id" => $autoController,
                "records_per_page" => $recordsPerPage,
                "columns_visible" => $columnVisible,
                "filter_by" => $filterBy
            ];
            $this->flatDb
                ->flatDatabase()
                ->update()
                ->in($this->channel)
                ->set($fileData)
                ->execute();
            return true;
        }
        return false;
    }

    /**
     * fetch a table settings by specifying the name of the settings we want to get 
     * the value for. ie 'records_per_page, columns_visible, filter_by etc...
     * 
     * @param string|null $controller
     * @return void
     */
    public function tableGetSettings(string $name, ?string $controller = null)
    {
        $autoController = $this->getCurrentController($controller);
        $options = $this
        ->flatDb
        ->flatDatabase()
        ->read()
        ->in($this->channel)
        ->where("id", "==", $autoController)
        ->get();

        $settings = [];
        foreach ($options as $option) {
            $settings = $option;
        }
        if (isset($settings[$name]) && $settings[$name] !='') {
            return $settings[$name];
        }
    }
}
