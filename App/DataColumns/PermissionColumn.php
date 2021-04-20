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
use App\Forms\Admin\Permission\PermissionForm;

class PermissionColumn extends AbstractDatatableColumn
{

    public function columns(array $dbColumns = []): array
    {
        return [
            [
                'db_row' => 'id',
                'dt_row' => '<input type="checkbox" class="uk-checkbox" id="chkAll" onclick="CheckUncheckAll(this)">',
                'class' => 'uk-table-shrink',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row) {
                    return '<input type="checkbox" class="uk-checkbox" id="permissions" name="id[]" value="' . $row['id'] . '" onclick="CheckUncheckHeader()">';
                }
            ],
            [
                'db_row' => 'permission_name',
                'dt_row' => 'Name',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row, $twigExt) {
                    $html = '';
                    $html .= '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left uk-margin-small-right">';
                    $html .= '<span class="uk-text-teal" uk-icon="icon: info"></span>';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left">';
                    $html .= $row["permission_name"] . "<br/>";
                    $html .= '<div class="uk-text-truncate uk-width-3-4"><small>' . $row["permission_description"] . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';

                    return $html;
                }
            ],
            [
                'db_row' => 'permission_description',
                'dt_row' => 'Description',
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
                'dt_row' => 'Modified',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'formatter' => function ($row, $twigExt) {
                    $html = '';
                    if (isset($row["modified_at"]) && $row["modified_at"] != null) {
                        $html .= $twigExt->tableDateFormat($row, "modified_at");
                        $html .= '<div><small>By Admin</small></div>';
                    } else {
                        $html .= '<small>Never!</small>';
                    }
                    return $html;
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
                            'edit_modal' => [
                                'icon' => 'ion-compose',
                                'tooltip' => 'Edit',
                                'toggle_modal_edit' => true,
                                'callback' => function ($row, $twigExt) {
                                    return $twigExt->getModal(
                                        [
                                            'toggle_id' => 'edit-modal-permission-' . $row['id'],
                                            'modal_title' => 'Edit ' . $row['permission_name'],
                                            'modal_content' => (new PermissionForm())
                                                ->createForm("/admin/permission/{$row['id']}/edit", $row)
                                        ]
                                    );
                                }
                            ],
                            'trash' => ['tooltip' => 'Trash', 'icon' => 'ion-ios-trash']
                        ],
                        $row,
                        $twigExt,
                        'permission',
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['permission_name']}</strong> permission."

                    );
                }
            ],

        ];
    }
}
