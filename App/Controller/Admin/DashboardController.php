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

use LoaderError;
use SyntaxError;
use RuntimeError;
use App\Model\UserModel;
use App\Schema\UserSchema;
use MagmaCore\Collection\Collection;

class DashboardController extends AdminController
{
    

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
        /*$schema = new UserSchema(new UserModel());
        var_dump($schema);
        die();*/

        /**
         * Dependencies are defined within a associative array like example below
         * [ userModel => \App\Model\UserModel::class ]. Where the key becomes the 
         * property for the userModel object like so $this->userModel->getRepo();
         */
        $this->diContainer(
            [
                "userRepo" => \App\Model\UserModel::class
            ]
        );  

    }

    /**
     * Entry method which is hit on request. This method should be implement within
     * all sub controller class as a default landing point when a request is 
     * made.
     *
     * @return Response
     * @throws LoaderError
     * @throws RuntimeError
     * @throws SyntaxError
     */
    protected function indexAction()
    { 
        /**$string = "name=firstname&length=190&null=false";
        $pipes = explode("&", $string);
        foreach ($pipes as $pipe) {
            if ($pipe) {

            }
        }*/

       // $colon = implode("@", $pipe);
       // $args = explode("@", $colon);
        /*return array_walk($args, function($value, $key, $args) {
            var_dump($value);
            die();
    
        }, $args);*/
        /*$usage = memory_get_usage();
        $peakUsage = memory_get_peak_usage();
        echo 'Memory Usage: ' . $this->convert($usage) . "<br>";
        echo 'Peak Usage: ' . $this->convert($peakUsage) . "<br>";*/
        $this->render(
            'admin/dashboard/index.html.twig',
            [
                "this" => $this
            ] 
        );
    }



}