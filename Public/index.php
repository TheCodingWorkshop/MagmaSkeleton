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

/**
 * Load main application directory path constant
 */
defined('ROOT_PATH') or define('ROOT_PATH', realpath(dirname(dirname(__FILE__))));
defined('DS') or define('DS', DIRECTORY_SEPARATOR);
defined('UPLOAD_PATH') or define("UPLOAD_PATH", $_SERVER['DOCUMENT_ROOT'] . DS . "uploads/");
defined('CONFIG_PATH') or define("CONFIG_PATH", ROOT_PATH . DS . "Config/");

/**
 * PHP 5.4 ships with a built in web server for development. This server
 * allows us to run silex without any configuration. However in order
 * to server static files we need to handle it nicely
 */
$filename = __DIR__ . preg_replace('#(\?.*)$#', '', $_SERVER['REQUEST_URI']);
if (php_sapi_name() == 'cli-server' && is_file($filename)) {
    return false;
}

/**
 * Requires composer autoload. Which loads external libraries and MagmaCore libraries
 */
$autoload = ROOT_PATH . '/vendor/autoload.php';
if (is_file($autoload)) {
    require $autoload;
}

/**
 * Load BaseApplication class. Which ignites and ties the MagmaCore framework
 * together.
 */

use MagmaCore\Base\BaseApplication;
use MagmaCore\Utility\Yaml;

$app = new BaseApplication();

/**
 * Set the application main root path
 */
$app->setPath(ROOT_PATH);

/**
 * Set the application main app.yaml configuration file. Please see documentation
 * for list of defaults which must be returned. Or simple copy and paste the default
 * configuration from the application github wiki page
 * 
 * 1. array - application app.yaml file
 */
$app->setConfig(
    $app->getFromYaml('app')
);

/**
 * Set the application session environment
 * 1. array session environment variables from session.yaml file. Defaults to internal settings
 * 2. string session identifier
 * 3. string session storage defaults to NativeSessionStorage already set internally
 */
$app->setSession(
    Yaml::file('session'),
    'my_application_session'
);
/*$app
->setContainer(Yaml::file('providers'))
    ->setConfig(Yaml::file('app'), Yaml::file('cache')['identifier'])
    ->setCookie(Yaml::file('cookie'))
    ->setSession(Yaml::file('session'), Yaml::file('session')['session_name'])
    ->setCache(Yaml::file('cache'))
    ->setRouter(Yaml::file('routes'), null, $_SERVER['QUERY_STRING'])
    ->setErrorHandler()
    ->setPath(ROOT_PATH)
    ->run();
*/
/**
 * Setup the application router.
 * 1. array of routes from application routes.yaml file should located within te Config directory
 * 2. Object - an optional router object if different from default. Default is loaded otherwise
 * 3. string - an optional field the route query ie. $_SERVER['QUERY_STRING'] which is already default
 */
$app->setRouter(
    $app->getFromYaml('routes'),
    null,
    $_SERVER['QUERY_STRING']
);

/**
 * Convert all errors to exception. By providing custom error and exception
 * handlers within the core. If we remove the below code then errors and exception
 * will be rendered as normal. This method provides a much more graceful way of 
 * displaying those errors and exceptions
 */
$app->setErrorHandlers();

/**
 * Return the fully configured application
 */
$app->run();

use MagmaCore\Http\Event\RequestEvent;
use MagmaCore\Http\Event\ResponseEvent;
use MagmaCore\Http\Event\BaseEvents;
use MagmaCore\Inertia\EventListener\InertiaListener;
use MagmaCore\EventDispatcher\EventDispatcher;
use MagmaCore\Http\ResponseHandler;
use MagmaCore\Http\RequestHandler;
use MagmaCore\Inertia\Service\Inertia;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

$res = new Response();
$req = new Request();
$inertia = new Inertia(ROOT_PATH, new Environment($loader));
$dispatcher = new EventDispatcher();
$loader = new FilesystemLoader('templates', TEMPLATE_PATH);
$listener = new InertiaListener($inertia);
$dispatcher->addListener('request', [$listener, 'onBaseRequest']);
$dispatcher->addListener('response', [$listener, 'OnBaseResponse']);
$dispatcher->dispatch(new RequestEvent($req, 1), 'request');
$dispatcher->dispatch(new ResponseEvent($req, 1, $res), 'response');

/*use MagmaCore\EventDispatcher\EventDispatcher;
use App\EventSubscriber\UserSubscriber;
use App\EventListener\NewUserListener;
use App\Event\NewUserEvent;
use App\Event\UserEdittedEvent;
use App\Event\UserDeletedEvent;

use App\Model\UserModel;

$dispatcher = new EventDispatcher();
$listener = new NewUserListener();
//$dispatcher->addListener(NewUserEvent::NAME, [$listener, 'onUserRegisterAction']);
$subscriber = new UserSubscriber();
$dispatcher->addSubscriber($subscriber);
//$dispatcher->addListener(NewUserEvent::NAME, function(){
    //echo __FUNCTION__;
//});

// /$dispatcher->dispatch(new NewUserEvent(new UserModel()), NewUserEvent::NAME);
$dispatcher->dispatch(new UserEdittedEvent(new UserModel()), UserEdittedEvent::NAME);
$dispatcher->dispatch(new UserDeletedEvent(new UserModel()), UserDeletedEvent::NAME);*/