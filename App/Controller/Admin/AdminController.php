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

use App\Event\FlashMessagesEvent;
use MagmaCore\Base\BaseController;
use MagmaCore\Session\SessionTrait;
use MagmaCore\Base\Traits\TableSettingsTrait;

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
        $this->container(
            [
                "tableGrid" => \MagmaCore\Datatable\Datatable::class /* Global Admin access */
            ]
        );
    }

    /**
     * Returns the method path as a string to use with the redirect method.
     * The method will generate the necessary redirect string based on the 
     * current route.
     *
     * @param string $action
     * @return string
     */
    public function selfPath(string $action): string
    {
        $self = '';
        if (!empty($this->thisRouteID()) && $this->thisRouteID() !== 0) {
            $self = "/admin/" . $this->thisRouteController() . "/" . $this->thisRouteID() . "/" . $action;
        } else {
            $self = "/admin/" . $this->thisRouteController() . "/" . $action;
        }

        if ($self) {
            return $self;
        }
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
            'AuthorizedIsNull' => \App\Middleware\Before\AuthorizedIsNull::class,
            'LoginRequired' => \App\Middleware\Before\LoginRequired::class,
            'AdminAuthentication' => \App\Middleware\Before\AdminAuthentication::class,
            'PreventionActions' => \App\Middleware\Before\PreventionActions::class,
            'SessionExpires' => \App\Middleware\Before\SessionExpires::class,
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
     * Return the flash event for the action route and also redirect
     *
     * @param array $actionEvent
     * @return void
     */
    public function getFlashEvent($actionEvent): void
    {
        if ($this->eventDispatcher) {
            $this->eventDispatcher->dispatch(new FlashMessagesEvent($actionEvent, $this), FlashMessagesEvent::NAME);
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
