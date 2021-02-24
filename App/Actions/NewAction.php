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

use MagmaCore\Base\Domain\DomainActionLogicInterface;
use MagmaCore\Base\Domain\DomainTraits;

/**
 * Class which handles the domain logic when adding a new item to the database
 * items are sanitize and validated before persisting to database. The class will 
 * also diaptched any validation error before persistence. The logic also implements
 * event dispatching which provide usable data for event listeners to perform other
 * necessary tasks and message flashing
 */
class NewAction implements DomainActionLogicInterface
{

    use DomainTraits;

    /** @return void - not currently being used */
    public function __construct()
    {
    }

    /**
     * execute logic for adding new items to the database()
     * 
     * @param Object $controller - The controller object implementing this object
     * @param string $eventDispatcher - the eventDispatcher for the current object
     * @param string $method - the name of the method within the current controller object
     * @return void
     */
    public function execute(
        Object $controller,
        string|null $entityObject = null,
        string|null $eventDispatcher = null,
        string $method,
        array $rules = [],
        array $additionalContext = []
    ): self {

        $this->controller = $controller;
        $this->method = $method;
        if (isset($controller->formBuilder)) :
            if ($controller->formBuilder->canHandleRequest() && $controller->formBuilder->isSubmittable($this->getFileName() . '-' . strtolower($controller->thisRouteController()))) {
                
                if ($controller->formBuilder->csrfValidate()) {
                    $action = $controller->repository->getRepo()
                        ->validateRepository(new $entityObject($controller->formBuilder->getData()))->persistAfterValidation();
                    if ($controller->error) {
                        $controller->error->addError($controller->repository->getRepo()->getValidationErrors(), $controller)->dispatchError();
                    }
                    if ($action) {
                        if ($controller->eventDispatcher) {
                            $controller->eventDispatcher->dispatch(
                                new $eventDispatcher(
                                    $method,
                                    array_merge(
                                        $controller->repository->getRepo()->validatedDataBag(),
                                        $additionalContext ? $additionalContext : []
                                    ),
                                    $controller
                                ),
                                $eventDispatcher::NAME
                            );
                        }
                    }
                }
            }
        endif;
        return $this;
    }
}
