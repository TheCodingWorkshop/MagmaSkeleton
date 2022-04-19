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

use MagmaCore\Base\Access;
use App\Model\MessageModel;
use App\Entity\MessageEntity;
use App\Schema\MessageSchema;
use App\Event\MessageActionEvent;
use App\DataColumns\MessageColumn;
use App\Commander\MessageCommander;
use MagmaCore\UserManager\UserModel;
use App\Forms\Admin\Message\MessageForm;
use App\Forms\Admin\Message\MessageReplyForm;
use MagmaCore\Base\Domain\Actions\ReplyAction;
use MagmaCore\Administrator\Model\ControllerSessionBackupModel;

class MessageController extends \MagmaCore\Administrator\Controller\AdminController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);

        $this->addDefinitions(
            [
                'repository' => MessageModel::class,
                'column' => MessageColumn::class,
                'commander' => MessageCommander::class,
                'entity' => MessageEntity::class,
                'messageForm' => MessageForm::class,
                'messageReplyForm' => MessageReplyForm::class,
                'userModel' => UserModel::class,
                'replyAction' => ReplyAction::class
            ]
        );
    }

    /**
     * Returns a 404 error page if the data is not present within the database
     * else return the requested object
     *
     * @return mixed
     */
    public function findOr404(): mixed
    {
        if (isset($this)) {
            return $this->repository->getRepo()
                ->findAndReturn($this->thisRouteID())
                ->or404();
        }
    }

    /**
     * Return an array of template context which is accessible from any route within this controller
     * @return array
     */
    protected function controllerViewGlobals(): array
    {
        return [
          'controller_message_sidebar' => $this->repository->messageStatusMenu()
        ];
    }

    protected function indexAction()
    {

        $this->indexAction
            ?->setAccess($this, Access::CAN_VIEW)
            ?->execute($this, NULL, NULL, MessageSchema::class, __METHOD__)
            ?->render()
            ?->with(
                [
                    'queried_status' => $this->request->handler()->query->getAlnum('status') ?: 'inbox',
                    'table_schema' => (string)$this->repository->getSchema()
                ]
            )
            ?->table()
            ?->end();
    }

    protected function newAction()
    {
        $this->newAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->messageForm)
            ->end();
    }

    protected function showAction()
    {
        $this->showAction
            ->execute($this, NULL, NULL, NULL, __METHOD__)
            ->render()
            ->with(
                [
                    'user' => $this->toArray($this->userModel->getUser((int)$_GET['user'])),
                    'row' => $this->toArray($this->findOr404())
                ]
            )
            ->form($this->messageForm)
            ->end();
    }

    protected function replyAction()
    {
        $this->replyAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__)
            ->render()
            ->with()
            ->form($this->messageReplyForm)
            ->end();
    }

    protected function forwardAction()
    {

    }

    /**
     * Change a user status to lock
     */
    protected function starredAction()
    {
        $this->changeStatusAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__, [], [], ['is_starred' => 1])
            ->endAfterExecution();
    }

    /**
     * Change a user status to lock
     */
    protected function unstarredAction()
    {
        $this->changeStatusAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__, [], [], ['is_starred' => 0])
            ->endAfterExecution();
    }

        /**
     * Change a user status to lock
     */
    protected function markedAction()
    {
        $this->changeStatusAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__, [], [], ['is_marked' => 1])
            ->endAfterExecution();
    }

    /**
     * Change a user status to lock
     */
    protected function unmarkedAction()
    {
        $this->changeStatusAction
            ->execute($this, MessageEntity::class, MessageActionEvent::class, NULL, __METHOD__, [], [], ['is_marked' => 0])
            ->endAfterExecution();
    }

    protected function settingsAction()
    {
        $sessionData = $this->getSession()->get($this->thisRouteController() . '_settings');
        $this->sessionUpdateAction
            ->execute($this, NULL, MessageActionEvent::class, NULL, __METHOD__, [], [], ControllerSessionBackupModel::class)
            ->render()
            ->with(
                [
                    'session_data' => $sessionData,
                    'page_title' => 'Message Settings',
                    'last_updated' => $this->controllerSessionBackupModel
                        ->getRepo()
                        ->findObjectBy(['controller' => $this->thisRouteController() . '_settings'], ['created_at'])->created_at
                ]
            )
            ->form($this->controllerSettingsForm, null, $this->toObject($sessionData))
            ->end();
    }

    protected function draftAction()
    {

    }


}

