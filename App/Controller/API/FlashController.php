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

namespace App\Controller\API;

use MagmaCore\Base\BaseController;
use MagmaCore\RestFul\RestHandler;
use MagmaCore\Session\Flash\Flash;
use MagmaCore\Session\SessionTrait;

class FlashController extends BaseController
{

    public function __construct(array $routeParams)
    {
        parent::__construct($routeParams);
        $this->diContainer(
            [
                'repository' => \App\Model\UserModel::class,
            ]
        );
    }

    /**
     * Validate if email is available (AJAX) for a new signup or an existing user.
     * The ID of an existing user can be passed in in the querystring to ignore when
     * checking if an email already exists or not.
     *
     * @return void
     */
    protected function flashMessageAction()
    {
        $messages = (new Flash(SessionTrait::sessionFromGlobal()))->get();
        if (is_array($messages) && count($messages) > 0) {
            foreach ($messages as $message) {
                extract ($message);
                if ($this->formBuilder->isAjax()) {
                    $response = [
                        "status" => true,
                        "message" => (isset($message) ? $message : ''),
                        "type" => (isset($type) ? $type : '')
                    ];
                    header('Content-type:application/json;charset=utf-8');
                    echo json_encode($response);
                    exit();
                }
            }
        }
    }
}
