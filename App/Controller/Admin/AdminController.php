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

namespace App\Controller\Admin;

use MagmaCore\Base\BaseController;
use MagmaCore\Datatable\Datatable;
use MagmaCore\Session\SessionTrait;
use App\Middleware\Before\LoginRequired;
use App\Middleware\Before\SessionExpires;
use App\Middleware\Before\AuthorizedIsNull;
use MagmaCore\Base\Traits\TableSettingsTrait;
use App\Middleware\Before\AdminAuthentication;
use MagmaCore\Base\Exception\BaseInvalidArgumentException;

class AdminController extends BaseController
{

    use SessionTrait;
    use TableSettingsTrait;

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
        $this->diContainer(
            [
                'tableGrid' => Datatable::class,
                'newAction' => \MagmaCore\Base\Domain\Actions\NewAction::class,
                'editAction' => \MagmaCore\Base\Domain\Actions\EditAction::class,
                'deleteAction' => \MagmaCore\Base\Domain\Actions\DeleteAction::class,
                'bulkDeleteAction' => \MagmaCore\Base\Domain\Actions\BulkDeleteAction::class,
                'indexAction' => \MagmaCore\Base\Domain\Actions\IndexAction::class,
                'showAction' => \MagmaCore\Base\Domain\Actions\ShowAction::class,
                'apiResponse' => \MagmaCore\RestFul\RestHandler::class

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
    protected function callBeforeMiddlewares(): array
    {
        return [
            'LoginRequired' => LoginRequired::class,
            'AdminAuthentication' => AdminAuthentication::class,
            'AuthorizedIsNull' => AuthorizedIsNull::class,
            'SessionExpires' => SessionExpires::class,
        ];
    }

    /**
     * After filter which is called after every controller. Can be used
     * for garbage collection
     *
     * @return array
     */
    protected function callAfterMiddlewares(): array
    {
        return [];
    }

    /**
     * Returns the method path as a string to use with the redirect method.
     * The method will generate the necessary redirect string based on the
     * current route.
     *
     * @param string $action
     * @return string
     */
    public function getRoute(string $action, Object $controller): string
    {
        $self = '';
        if (!empty($this->thisRouteID()) && $this->thisRouteID() !== false) {
            if ($this->thisRouteID() === $this->findOr404($controller)->id) {
                $route = "/{$this->thisRouteNamespace()}/{$this->thisRouteController()}/{$this->thisRouteID()}/{$this->thisRouteAction()}";
            }
        } else {
            $self = "/{$this->thisRouteNamespace()}/{$this->thisRouteController()}/{$action}";
        }

        if ($self) {
            return $self;
        }
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
}
