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

use MagmaCore\Utility\Yaml;
use MagmaCore\Utility\DirtyConnection;

class InstallRepository
{

    protected array $errors = [];
    protected string $envName = '/.env.lip';
    protected array $newCleanData;

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
                'db_driver' => isset($cleanData['db_driver']) ? $cleanData['db_driver'] : Yaml::file('app')['databse']['database_pdo_driver'],
                'db_host' => isset($cleanData['db_host']) ? $cleanData['db_host'] : '127.0.0.1',
                'db_user' => isset($cleanData['db_user']) ? $cleanData['db_user'] : 'root',
                'db_name' => isset($cleanData['db_name']) ? $cleanData['db_name'] : '',
                'db_password' => isset($cleanData['db_password']) ? $cleanData['db_password'] : '',
                'db_port' => isset($cleanData['db_port']) ? intval($cleanData['db_port']) : 3306,
                'db_prefix' => isset($cleanData['db_prefix']) ? $cleanData['db_prefix'] : ''
            ];
        }
        return $this;
    }

    /**
     * Create the .env file within the project root directory. Using the parameters
     * returned from the $this->newCleanData array
     *
     * @return int|false
     */
    public function create(): void
    {
        if ($this->newCleanData) {
            $env = '';
            $env .= 'DB_DRIVER=' . $this->newCleanData['db_driver'] . "\n";
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

    public function getErrors()
    {
        return $this->errors;
    }

    private function validate(mixed $cleanData): array
    {
        if (count($cleanData) > 0) {
            foreach ($cleanData as $key => $value) {
                switch ($key):
                    case 'db_driver':
                        if (!in_array($value, Yaml::file('app')['database']['supported_drivers'])) {
                            $this->errors[] = 'Unsupported database driver selected.';
                        }
                        break;
                    case 'db_host' :
                        if (isset($value)) {
                            if (empty($value)) {
                                $this->errors[] = 'Server host name can not be left empty.';
                            }
                        }
                        break;
                    case 'db_name':
                    case 'db_user':
                        if (isset($value)) {
                            if (empty($value)) {
                                $this->errors[] = 'Error: One or more fields are empty. Please fill in the required details.';
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
                                $this->errors[] = '<strong>Table Prefix</strong> must not be empty';
                            }
                            if (preg_match('|[^a-z0-9_]|i', $value)) {
                                $this->errrors[] = '<strong>Table Prefix</strong> can only contain numbers, letters and underscore';
                            }
                        }
                        break;
                    case 'db_port':
                        break;
                endswitch;
            }
            return $this->errors;
        }
    }
}
