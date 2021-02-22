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

namespace App\Repository;

use MagmaCore\Auth\Contracts\UserActivationInterface;
use App\Model\UserModel;
use MagmaCore\Utility\HashGenerator;
use MagmaCore\Utility\Token;
use MagmaCore\Base\BaseView;
use MagmaCore\Mailer\MailerFacade;

class ActivationRepository extends UserModel implements UserActivationInterface
{ 

    protected array $errors = [];

    /**
     * Undocumented function
     *
     * @param string $token
     * @return Object|null
     */
    public function findByActivationToken(string $token) : ?Object
    { 
        $token = new Token($token);
        $_tokenHash = $token->getHash();
        $findBy = $this->getRepo()->findObjectBy(['activation_token' => $_tokenHash], ['*']);
        if (null !== $findBy) {
            return $findBy;
        }

        return null;
    }

    /**
     * Undocumented function
     *
     * @param string $hash
     * @return self
     */
    public function sendUserActivationEmail(string $hash) : self
    { 
        $mail = (new MailerFacade())->basicMail(
            'Activate Your Account',
            'admin@magmacore.com',
            $this->userEmail,
            (new BaseView())->getTemplate('client/registration/activation_email.html.twig',["url" => "http://{$_SERVER['HTTP_HOST']}/activation/activate/{$this->hash}"])
        );
        if ($mail) {
            return true;
        }
        return $this;

    }

    /**
     * Undocumented function
     *
     * @param Object|null $repository
     * @return self
     */
    public function validateActivation(?Object $repository) : self
    { 
        if ($repository === null) {
            $this->errors[] = 'Sorry no user was found!';
            //throw new \InvalidArgumentException();
        }
        $this->userID = $repository->id;
        $this->fields = ['activation_token' => NULL, 'status' => 'active'];
        return $this;
    }

    /**
     * Undocumented function
     *
     * @return boolean
     */
    public function activate() : bool
    { 
        $update = $this->getRepo()->findByIdAndUpdate($this->fields, $this->userID);
        if ($update) {
            return $update;
        }
        return false;
    }

    public function getErrors()
    {
        return $this->errors;
    }


}