
<?php

$method = new \ReflectionMethod($this->controller, $this->action); 
 
$args = []; 
 
foreach ($method->getParameters() as $param) {
 
    $name = $param->getName();
 
    $class = $param->getClass();
 
    if ($class === null) {  // No class type hint
 
        $args[] = $route_params[$name];
 
    } else {
 
        if ($class->isInstance($request)) {
 
            $args[] = $request;
 
        } else {
 
            // check other types, or throw exception if invalid
 
        }   
 
        return call_user_func_array([$this->controller, $this->action], $args);
    }

        /**
     * @inheritDoc
     * @throws RouterException
     */
    public function dispatch(string $url, $args = null)
    {
        $url = $this->removeQueryStringVariables($url);
        if ($this->match($url)) {
            $controllerName = $this->params['controller'] . $this->controllerSlug;
            $controllerName  = $this->transformUpperCamelCases($controllerName);
            $controllerName = $this->getNamespace() . $controllerName;
            
            if (class_exists($controllerName)) {
                $reflectionClass = BaseApplication::diGet($controllerName);
                if ($reflectionClass) {
                    $method = $this->params['action'];
                    $method = $this->transformLowerCamelCase($method);
                    if (is_callable([$reflectionClass, $method])) {
                        $this->resolvedMethod(
                            $reflectionClass, 
                            $method,
                            [
                                
                            ]
                        );
                    }
                }
               /* $controllerObject = new $controllerName($this->params);
                $action = $this->params['action'];
                $action = $this->transformLowerCamelCase($action);

                if (is_callable([$controllerObject, $action])) {
                    $controllerObject->$action();
                } else {
                    throw new RouterBadMethodCallException("Method {$action} does not exists.");
                }*/
            } else {
                throw new RouterBadFunctionCallException("Class {$controllerName} does not exists.");
            }

        } else {
            throw new RouterNoRoutesFound("Route {$url} does not match any valid route.", 404);
        }
    }

    /**
     * Undocumented function
     *
     * @param object $object
     * @param mixed $method
     * @param array $args
     * @return mixed
     */
    public function resolvedMethod(object $object, mixed $method, array $args = []): mixed
    {
        $reflection = new ReflectionMethod($object, $method);
        $reflection->setAccessible(true);
        $pass = [];
        foreach ($reflection->getParameters() as $param) {
            if (isset($args[$param->getName()])) {
                $pass[] = $args[$param->getName()];
            } else {
                if ($param->isDefaultValueAvailable()) {
                    $pass[] = $param->getDefaultValue();
                } else {
                    $pass[] = '';
                }
            }
        }
        return $reflection->invokeArgs($object, $pass);
    }
