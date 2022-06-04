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

use MagmaCore\Base\Traits\ControllerCommonTrait;

/**
 * Controller which allows crud operation of the different cost center for your company
 * methods
 * 
 * indexAction
 * showAction
 * newAction
 * editAction
 * copyAction
 * trashAction
 * untrashAction
 * hardDeleteAction
 * bulkAction
 */
class EmployeeLeavesController extends \MagmaCore\Administrator\Controller\AdminController
{

    use ControllerCommonTrait;

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
            ]
        );
    }

}