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

    public function columns(): array
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
                    $html .= $this->status($row);
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
                'show_column' => false,
                'sortable' => false,
                'formatter' => function ($row, $twigExt) {
                    return '<span uk-icon="icon: location" uk-tooltip="' . $row["remote_addr"] . '"></span>';
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
                            'user' => [],
                            'file-edit' => [],
                            'trash' => []
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

    /**
     * @inheritDoc
     */
    public function status(?array $row): string
    {
        $html = '';

        switch ($row["status"]) {
            case "pending":
                $html .= '<span class="uk-text-warning" uk-icon="icon: warning; ratio: .8" uk-tooltip="' . ($row["status"] == 'pending' ? 'pending' : '') . '"></span>';
                break;
            case "active":
                $html .= '<span class="uk-text-success" uk-icon="icon: check; ratio: .8" uk-tooltip="' . ($row["status"] == 'active' ? 'active' : '') . '"></span>';
                break;
            case "lock":
                $html .= '<span class="uk-text-secondary" uk-icon="icon: lock; ratio: .8" uk-tooltip="' . ($row["status"] == 'lock' ? 'lock' : '') . '"></span>';
                break;
            case "trash":
                $html .= '<span class="uk-text-danger" uk-icon="icon: trash; ratio: .8" uk-tooltip="' . ($row["status"] == 'trash' ? 'trash' : '') . '"></span>';
                break;
        }
        return $html;
    }
}