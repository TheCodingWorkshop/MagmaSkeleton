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

use App\Model\UserModel;
use MagmaCore\Utility\Curl;
use MagmaCore\Numbers\Number;

class DashboardRepository
{

    private UserModel $user;
    private Number $number;

    public function __construct(UserModel $user, Number $number)
    {
        $this->user = $user;
        $this->number = $number;
        $this->number->addNumber($this->user->getRepo()->count());
    }

    public function countlastMountUsers()
    {
        $query = $this->user->getRepo()->getEm()->getCrud();
        $userLastMonth = $query->rawQuery("SELECT COUNT(*) as created_at 
        FROM {$this->user->getSchema()}
        WHERE created_at BETWEEN DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL DAY(CURRENT_DATE())-1 DAY), INTERVAL 1 MONTH)
        AND DATE_SUB(CURRENT_DATE(), INTERVAL DAY(CURRENT_DATE()) DAY)", [], 'column');

        if ($userLastMonth)
            return $userLastMonth;
    }

    public function countlastWeekUsers()
    {
        $query = $this->user->getRepo()->getEm()->getCrud();
        $userLastWeek = $query->rawQuery("SELECT COUNT(*) as created_at 
        FROM {$this->user->getSchema()}
        WHERE created_at BETWEEN SUBDATE(CURRENT_DATE(), INTERVAL 7 + WEEKDAY(CURRENT_DATE()) DAY)
  AND SUBDATE(CURRENT_DATE(), INTERVAL 1+WEEKDAY(CURRENT_DATE()) DAY)", [], 'column');

        if ($userLastWeek)
            return $userLastWeek;
    }
    public function countCurrentWeekUsers()
    {
        $query = $this->user->getRepo()->getEm()->getCrud();
        $userLastWeek = $query->rawQuery("SELECT COUNT(*) as created_at 
        FROM {$this->user->getSchema()}
        WHERE WHERE created_at BETWEEN SUBDATE(CURRENT_DATE(), INTERVAL WEEKDAY(CURRENT_DATE()) DAY)
  AND CURRENT_DATE()", [], 'column');

        if ($userLastWeek)
            return $userLastWeek;
    }


    public function getQuickLinks(): array
    {
        return [
            'privilege' => ['name' => 'Create new privileges', 'path' => '/admin/role/new'],
            'static_pages' => ['name' => 'Add some static pages', 'path' => '/admin/page/new'],
            'privileges' => ['name' => 'View your site', 'path' => '/'],
            'extension' => ['name' => 'Configure extensions', 'path' => '']
        ];
    }

    public function getStatistics(): array
    {
        return [
            'user' => ['icon' => 'person', 'counter' => 1.2, 'percentage' => 8],
            'page' => ['icon' => 'document-text', 'counter' => 1.3, 'percentage' => 13],
            'attachment' => ['icon' => 'document-attach', 'counter' => 1.5, 'percentage' => 2.5],
            'unread_message' => ['icon' => 'mail-unread', 'counter' => 1.0, 'percentage' => 5.3]
        ];
    }

    public function getGithubStats()
    {
        return [
            'branch' => ['icon' => 'git-branch', 'counter' => 1.2, 'percentage' => 8],
            'pull' => ['icon' => 'git-pull-request', 'counter' => 1.3, 'percentage' => 13],
            'commit' => ['icon' => 'git-commit', 'counter' => 1.5, 'percentage' => 189],
            'merge' => ['icon' => 'git-merge', 'counter' => 1.0, 'percentage' => 5.3]
        ];
    }

    /**
     * Return the total records from the users database table
     *
     * @return integer
     */
    public function totalUsers(): int
    {
        return $this->user->getRepo()->count();
    }

    /**
     * Get the total number of pending users from the database table
     *
     * @return integer
     */
    public function totalPendingUsers(): int
    {
        $count = $this->user->getRepo()->count(['status' => 'pending'], $this->user->getSchema());
        if ($count)
            return $count;
    }

    /**
     * Gte the total number of active users from the database table
     *
     * @return integer
     */
    public function totalActiveUsers(): int
    {
        $count = $this->user->getRepo()->count(['status' => 'active'], $this->user->getSchema());
        if ($count)
            return $count;
    }

    /**
     * Gte the total number of lock users from the database table
     *
     * @return integer
     */
    public function totalLockedUsers(): int
    {
        $count = $this->user->getRepo()->count(['status' => 'lock'], $this->user->getSchema());
        if ($count)
            return $count;
    }

    /**
     * Gte the total number of trash users from the database table
     *
     * @return integer
     */
    public function totalTrashUsers(): int
    {
        $count = $this->user->getRepo()->count(['status' => 'trash'], $this->user->getSchema());
        if ($count)
            return $count;
    }


    /**
     * Return an percentage array of the pending and active users against the total
     * records of users account
     *
     * @return array
     */
    public function userPercentage(): array
    {
        $this->number->addNumber($this->totalUsers());
        $activeUsers = $this->number->percentage($this->totalActiveUsers());
        $pendingUsers = $this->number->percentage($this->totalPendingUsers());
        $lockedUsers = $this->number->percentage($this->totalLockedUsers());
        $trashUsers = $this->number->percentage($this->totalTrashUsers());
        return [
            'active' => ['percentage' => $this->number->format($activeUsers)],
            'pending' => ['percentage' => $this->number->format($pendingUsers)],
            'lock' => ['percentage' => $this->number->format($lockedUsers)],
            'trash' => ['percentage' => $this->number->format($trashUsers)]
        ];
    }

    public function mainCards()
    {
        return [
            'Team' => [
                'icon' => 'people-outline', 
                'desc' => [
                    'Found 2 superadmin account and 1 contributor account.',
                ]
            ],
            'Tasks' => [
                'icon' => 'clipboard-outline',
                'desc' => [
                    'There are 12 incomplete tasks and 3 completed tasks.'
                ]
            ],
            'Events' => [
                'icon' => 'calendar-outline', 
                'desc' => [
                    '2 events coming up next week'
                ]
            ]
        ];
    }

    /**
     * Return an percentage array of the pending and active users against the total
     * records of users account
     *
     * @return array
     */
    public function userSession(): array
    {
        // $this->number->addNumber($this->totalUsers());
        // $activeUsers = $this->number->percentage($this->totalActiveUsers());
        // $pendingUsers = $this->number->percentage($this->totalPendingUsers());
        // $lockedUsers = $this->number->percentage($this->totalLockedUsers());
        // $trashUsers = $this->number->percentage($this->totalTrashUsers());
        return [
            'tv' => ['count' => 2.6, 'name' => 'Total Visits'],
            'on' => ['count' => 9.6, 'name' => 'Online'],
        ];
    }

    public function getSessionUniqueVisits()
    {
        return 1.4;
    }


    public function getNavSwitcher()
    {
        return [
            'home' => ['icon' => 'home-outline', 'include' => 'block_links'],
            'session' => ['icon' => 'stats-chart-outline', 'include' => 'block_statistics'],
            'github' => ['icon' => 'logo-github', 'include' => 'block_github'],
            'health' => ['icon' => 'pulse-outline', 'include' => 'block_health_status'],
            'news' => ['icon' => 'newspaper-outline', 'include' => 'block_response'],
        ];
    }

    public function getGithubSettings()
    {
        $plugin = 'Overlay';
        $cachePath =  $_SERVER['DOCUMENT_ROOT'] . '/plugin-cache/';
        $cacheFile = $plugin . '-github.txt';
        return $this->getJsonRepository($cachePath . $cacheFile, $plugin);
    }

    public function getGithubContent(string $url)
    {
        if ($url) {
            return Curl::get($url);
        }
    }

    public function getJsonRepository($file, $plugin)
    {
        $currentTime = time();
        $expireTime = 24 * 60 * 60;
        $fileTime = filemtime($file);
        if (file_exists($file) && ($currentTime - $expireTime < $fileTime)) {
            return json_decode(file_get_contents($file));
        } else {
            $json = array();
            $json['repo'] = json_decode($this->getGithubContent('http://github.com/api/v2/json/repos/show/darkwing/' . $plugin), true);
            $json['commit'] = json_decode($this->getGithubContent('http://github.com/api/v2/json/commits/list/darkwing/' . $plugin . '/master'), true);
            $json['readme'] = json_decode($this->getGithubContent('http://github.com/api/v2/json/blob/show/darkwing/' . $plugin . '/' . $json['commit']['commits'][0]['parents'][0]['id'] . '/Docs/' . $plugin . '.md'), true);
            $json['js'] = json_decode($this->getGithubContent('http://github.com/api/v2/json/blob/show/darkwing/' . $plugin . '/' . $json['commit']['commits'][0]['parents'][0]['id'] . '/Source/' . $plugin . '.js'), true);
            file_put_contents($file, json_encode($json));
            return $json;
        }
    }


    public function githubDump()
    {
        var_dump($this->getGithubSettings());
        // if($this->githubJson) {

        //     //get markdown
        //     include($_SERVER['DOCUMENT_ROOT'].'/wp-content/themes/walshbook3/PHP-Markdown-Extra-1.2.4/markdown.php');

        //     //build content
        //     $content = '<p>'.$github_json['repo']['repository']['description'].'</p>';
        //     $content.= '<h2>MooTools JavaScript Class</h2><pre class="js">'.$github_json['js']['blob']['data'].'</pre><br />';
        //     $content.= trim(str_replace(array('<code>','</code>'),'',Markdown($github_json['readme']['blob']['data'])));
        // }
    }
}
