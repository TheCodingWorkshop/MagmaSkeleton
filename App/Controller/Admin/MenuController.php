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

use MagmaCore\PanelMenu\EventSubscriber\MenuActionSubscriber;

class MenuController extends \MagmaCore\PanelMenu\MenuController
{

    protected function trashAction()
    {
        $this->deleteAction
            ->execute($this, NULL, MenuActionSubscriber::class, NULL, __METHOD__)
            ->endAfterExecution();
    }

}

