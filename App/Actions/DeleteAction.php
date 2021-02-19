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

namespace App\Actions;

/**
 * Class which handles the domain logic when adding a new item to the database
 * items are sanitize and validated before persisting to database. The class will 
 * also diaptched any validation error before persistence. The logic also implements
 * event dispatching which provide usable data for event listeners to perform other
 * necessary tasks and message flashing
 */
class DeleteAction
{

    /** @return void - not currently being used */
    public function __construct()
    { }

    /**
     * execute logic for adding new items to the database()
     * 
     * @param Object $controller - The controller object implementing this object
     * @param string $eventDispatcher - the eventDispatcher for the current object
     * @param string $method - the name of the method within the current controller object
     * @param array $additionalContext - additional data which can be passed to the event dispatcher
     * @return void
     */
    public function execute(
        Object $controller,
        string $eventDispatcher,
        string $method,
        array $additionalContext = []
    ) {
        if (isset($controller->formBuilder)) :
            if ($controller->formBuilder->canHandleRequest()) {
                if ($controller->repository->getRepo()->findAndReturn($controller->thisRouteID())->or404() !== $controller->thisRouteID()) {
                    if ($controller->error) {
                        $controller->error->addError(['Error deleting!'], $controller)->dispatchError($controller->onSelf());
                    }
                }
                $action = $controller->repository->getRepo()->findByIdAndDelete(['id' => $controller->thisRouteID()]);
                if ($action) {
                    if ($controller->eventDispatcher) {
                        $controller->eventDispatcher->dispatch(
                            new $eventDispatcher(
                                $method,
                                ['action' => $action],
                                $controller
                            ),
                            $eventDispatcher::NAME
                        );
                    }
                }
            }
        endif;
    }
}
