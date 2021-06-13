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

use MagmaCore\Error\Error;
use MagmaCore\Utility\Yaml;

class InstallRepository
{

    protected string $envName = '/.env.lip';
    protected array $newCleanData;
    private array $errors;

    /**
     * Validate the first step of the installation process before creating the env
     * configuration file
     *
     * @param mixed $cleanData
     * @return self
     */
    public function validateBeforeCreateConfig(mixed $cleanData): self
    {
        $this->validate($cleanData);
        if (empty($this->errors)) {
            $this->newCleanData = [
                'db_driver' => $cleanData['db_driver'] ?? Yaml::file('app')['database']['database_pdo_driver'],
                'db_host' => $cleanData['db_host'] ?? '127.0.0.1',
                'db_user' => $cleanData['db_user'] ?? 'root',
                'db_name' => $cleanData['db_name'] ?? '',
                'db_password' => $cleanData['db_password'] ?? '',
                'db_port' => isset($cleanData['db_port']) ? intval($cleanData['db_port']) : 3306,
                'db_prefix' => $cleanData['db_prefix'] ?? ''
            ];
        }
        return $this;
    }

    /**
     * Create the .env file within the project root directory. Using the parameters
     * returned from the $this->newCleanData array
     *
     * @return void
     */
    public function create(): void
    {
        if ($this->newCleanData) {
            $env = 'DB_DRIVER=' . $this->newCleanData['db_driver'] . "\n";
            $env .= 'DB_HOST=' . $this->newCleanData['db_host'] . "\n";
            $env .= 'DB_NAME=' . $this->newCleanData['db_name'] . "\n";
            $env .= 'DB_USER=' . $this->newCleanData['db_user'] . "\n";
            $env .= 'DB_PASSWORD=' . $this->newCleanData['db_password'] . "\n";
            $env .= 'DB_PORT=' . $this->newCleanData['db_port'] . "\n";
            $env .= 'DB_PREFIX=' . $this->newCleanData['db_prefix'] . "\n\n";
            $env .= 'DB_COLLATE=' . 'utf8_unicode_ci' . "\n";
            $env .= 'DB_CHARSET=' . 'utf8mb4' . "\n";
            $env .= 'DB_ENGINE=' . 'InnoDB' . "\n";
            $env .= 'DB_FORMAT=' . 'dynamic' . "\n";

            file_put_contents(APP_ROOT . $this->envName, $env);
        }
    }

    public function getErrors(): array
    {
        return $this->errors;
    }

    private function validate(mixed $cleanData): void
    {
        if (count($cleanData) > 0) {
            foreach ($cleanData as $key => $value) {
                switch ($key):
                    case 'db_driver':
                        if (!in_array($value, Yaml::file('app')['database']['supported_drivers'])) {
                            $this->errors = Error::display('err_unsupport_driver');
                        }
                        break;
                    case 'db_host' :
                        if (isset($value)) {
                            if (empty($value)) {
                                $this->errors = Error::display('err_empty_host');
                            }
                        }
                        break;
                    case 'db_name':
                    case 'db_user':
                        if (isset($value)) {
                            if (empty($value)) {
                                $this->errors = Error::display('err_field_require');
                            }
                            /*if ($key === 'db_name') {
                                if (!isset($conn)) {
                                    $conn = new DirtyConnection($cleanData['db_host'], $cleanData['db_user'], $cleanData['db_password'], $cleanData['db_name']);
                                }
                                if ($conn->dirtyConnect()->connect_error || $conn->dirtyConnect()->select_db($cleanData['db_name']) && !$conn->dirtyConnect()->select_db($cleanData['db_name'])) {
                                    $this->errors[] = 'Error connecting ' . $conn->dirtyConnect()->connect_error;
                                }
                                $conn->close();
                            }*/
                        }
                        break;
                    case 'db_prefix':
                        if (isset($value)) {
                            if (empty($value)) {
                                $this->errors = Error::display('err_empty_dbprefix');
                            }
                            if (preg_match('|[^a-z0-9_]|i', $value)) {
                                $this->errors = Error::display('err_invalid_dbprefix');
                            }
                        }
                        break;
                    case 'db_port':
                        break;
                endswitch;
            }
        }
    }
}
