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

use MagmaCore\Datatable\AbstractDatatableColumn;

class UserColumn extends AbstractDatatableColumn
{

    public function columns(array $dbColumns = []): array
    {
        return [
            [
                'db_row' => 'id',
                'dt_row' => '<input type="checkbox" class="uk-checkbox" id="chkAll" onclick="checkUncheckAll()">',
                'class' => 'uk-table-shrink',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row) {
                    return '<input type="checkbox" class="uk-checkbox" id="user-' . $row['id'] . '" name="id" value="' . $row['id'] . '">';
                }
            ],
            [
                'db_row' => 'firstname',
                'dt_row' => 'Name',
                'class' => 'uk-table-expand',
                'show_column' => true,
                'sortable' => true,
                'formatter' => function ($row) {
                    $html = '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left">';
                    $html .= '<img src="' . $row["gravatar"] . '" width="40" class="uk-border-circle">';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left uk-margin-small-right">';
                    $html .= '<div>' . $this->getStatus($row) . '</div>';
                    $html .= '<div>' . $this->getRole($row) . '</div>';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left">';
                    $html .= $row["firstname"] . ' ' . $row["lastname"] . "<br/>";
                    $html .= '<div><small>' . $row["email"] . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';
                    return $html;
                }
            ],
            [
                'db_row' => 'lastname',
                'dt_row' => 'Lastname',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'email',
                'dt_row' => 'Email Address',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'status',
                'dt_row' => 'Status',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'created_at',
                'dt_row' => 'Published',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'formatter' => function ($row, $twigExt) {
                    $html = $twigExt->tableDateFormat($row, "created_at");
                    $html .= '<div><small>By Admin</small></div>';
                    return $html;
                }
            ],
            [
                'db_row' => 'modified_at',
                'dt_row' => 'Last Modified',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'formatter' => function ($row, $twigExt) {
                    $html = '';
                    if (isset($row["modified_at"]) && $row["modified_at"] != null) {
                        //$html .= "$twig->getUserById($row[$row_name]);"
                        $html .= $twigExt->tableDateFormat($row, "modified_at");
                        $html .= '<div><small>By Admin</small></div>';
                    } else {
                        $html .= '<small>Never!</small>';
                    }
                    return $html;
                }
            ],
            [
                'db_row' => 'gravatar',
                'dt_row' => 'Thumbnail',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'ip',
                'dt_row' => 'IP',
                'class' => 'uk-table-shrink',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row, $twigExt) {
                    return '<span class="ion-location ion-24" uk-tooltip="' . $row["remote_addr"] . '"></span>';
                }
            ],
            [
                'db_row' => '',
                'dt_row' => 'Action',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row, $twigExt) {
                    return $twigExt->action(
                        [
                            'user' => ['icon' => 'ion-person'],
                            'file-edit' => ['icon' => 'ion-compose'],
                            'trash' => ['icon' => 'ion-ios-trash']
                        ],
                        $row,
                        $twigExt,
                        'user',
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['firstname']}</strong> account."
                    );
                }
            ],

        ];
    }

    private function getRole(array $row)
    {

    }

    /**
     * @inheritDoc
     */
    private function getStatus(array $row): string
    {
        $html = '';

        switch ($row["status"]) {
            case "pending":
                $html .= '<span class="uk-text-warning ion-alert-circled" uk-tooltip="' . ($row["status"] == 'pending' ? 'Pending' : '') . '"></span>';
                break;
            case "active":
                $html .= '<span class="uk-text-success ion-android-done" uk-tooltip="' . ($row["status"] == 'active' ? 'Active' : '') . '"></span>';
                break;
            case "lock":
                $html .= '<span class="uk-text-secondary ion-locked" uk-tooltip="' . ($row["status"] == 'lock' ? 'Lock' : '') . '"></span>';
                break;
            case "trash":
                $html .= '<span class="uk-text-danger ion-ios-trash" uk-tooltip="' . ($row["status"] == 'trash' ? 'Trash' : '') . '"></span>';
                break;
        }
        return $html;
    }
}
