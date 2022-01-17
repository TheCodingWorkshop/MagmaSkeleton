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

namespace App\DataColumns;

use MagmaCore\UserManager\UserModel;
use MagmaCore\Datatable\AbstractDatatableColumn;

class MessageColumn extends AbstractDatatableColumn
{

    private UserModel $userModel;

    public function __construct(UserModel $userModel)
    {
        $this->userModel = $userModel;
    }

    /**
     * @param array $dbColumns
     * @param object|null $callingController
     * @return array[]
     */
    public function columns(array $dbColumns = [], object|null $callingController = null): array
    {
        return [
            [
                'db_row' => 'id',
                'dt_row' => 'ID',
                'class' => 'uk-table-shrink',
                'show_column' => true,
                'sortable' => false,
                'searchable' => false,
                'formatter' => function ($row) {
                    return '<input type="checkbox" class="uk-checkbox" id="menus-' . $row['id'] . '" name="id[]" value="' . $row['id'] . '">';
                }
            ],
            [
                'db_row' => 'subject',
                'dt_row' => 'Primary',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    $data = $this->userModel->getUser($row['user_id']);
                    $html = '<div class="uk-grid-small uk-flex-middle" uk-grid>';
                    $html .= '<div class="uk-width-auto">';
                    $html .= '<img class="uk-border-circle" width="40" height="40" src="' . $data->gravatar . '">';
                    $html .= '</div>';

                    $html .= ' <div class="uk-width-expand">';
                    $html .= '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left uk-text-small">';
                    $html .= $data->firstname . ' ' . $data->lastname . ' - ' . $this->truncate($row['subject'], 50, 30);
                    $html .= '</div>';
                    $html .= '<div class="uk-float-right">';
                    $html .= $this->messageActions($row, $tempExt);
                    $html .= '</div>';

                    $html .= '</div>';
                    $html .= '<p class="uk-text-meta uk-margin-remove-top uk-text-truncate"><a class="uk-text-link uk-link-reset" href="/admin/message/' . $row['id'] . '/show?user=' . $row['user_id'] . '">' . $this->truncate($row['body']) . '</a></p>
                        ';
                    $html .= '</div>';

                    return $html;
                }
            ],
            [
                'db_row' => 'body',
                'dt_row' => 'Message',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['body'] ?? 'None';
                }
            ],
            [
                'db_row' => 'status',
                'dt_row' => 'Status',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['status'] ?? 'None';
                }
            ],
            [
                'db_row' => 'is_marked',
                'dt_row' => 'Marked',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['is_marked'] ?? 0;
                }
            ],
            [
                'db_row' => 'is_starred',
                'dt_row' => 'Starred',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['is_starred'] ?? 0;
                }
            ],

            [
                'db_row' => 'created_byid',
                'dt_row' => 'Author',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['created_byid'] ?? 'None';
                }
            ],
            [
                'db_row' => 'created_at',
                'dt_row' => 'Published',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    $html = $tempExt->tableDateFormat($row, "created_at", true);
                    $html .= '<div><small>By Admin</small></div>';
                    return $html;
                }
            ],
            [
                'db_row' => '',
                'dt_row' => 'Action',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    return $tempExt->action(
                        [
                            'archive' => ['tooltip' => 'Archive', 'icon' => 'ion-archive'],
                        ],
                        $row,
                        $tempExt,
                        'notification',
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['subject']}</strong> role."
                    );
                }
            ],

        ];
    }

    public function messageActions(array $row, object $tempExt)
    {   
        /* link */
        $starred = ($row['is_starred'] == 1 ? 'unstarred' : 'starred');
        $marked = ($row['is_marked'] == 1 ? 'unmarked' : 'marked');
        /* icon */
        $starred_icon = ($row['is_starred'] == 1 ? 'star' : 'star-outline');
        $marked_icon = ($row['is_marked'] == 1 ? 'mail-open-outline' : 'mail-outline');
        /* tooltip */
        $starred_tip = ($row['is_starred'] == 1 ? 'UnStarred' : 'Starred');
        $marked_tip = ($row['is_marked'] == 1 ? 'Mark as Unread' : 'Mark as Read');

        $html = '<ul class="uk-iconnav">';
        $html .= '<li><ion-icon name="attach-outline"></ion-icon></li>';
        $html .= '<li><small><time datetime="' . $row['created_at'] . '">' . $tempExt->tableDateFormat($row, 'created_at') . '</time></small></li>';

        $html .= '<li><a uk-tooltip="' . $starred_tip . '" href="/admin/message/' . $row['id'] . '/' . $starred . '"><ion-icon name="' . $starred_icon . '"></ion-icon></a></li>';

        $html .= '<li><a uk-tooltip="' . $marked_tip . '" href="/admin/message/' . $row['id'] . '/' . $marked . '"><ion-icon name="' . $marked_icon . '"></ion-icon></a></li>';

        $html .= '<li><a href="#"><ion-icon name="settings-outline"></ion-icon></a></li>';
        $html .= '</ul>';

        return $html;
    }

    public function truncate(string $str, int $max = 100, int $min = 80)
    {
        if (strlen($str) > $max)
            $str = substr($str, 0, $min) . ' ...';

        return $str;
    }
}
