<?php
class Autoloader
{
    static function register()
    {
        spl_autoload_register(array(__CLASS__, 'autoload'));
    }

    static function autoload($classname)
    {
        require $classname . ".class.php";
    }
}
