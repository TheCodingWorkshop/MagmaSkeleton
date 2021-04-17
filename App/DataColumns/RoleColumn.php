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

use App\Forms\Admin\Role\RoleForm;
use MagmaCore\Auth\Model\RolePermissionModel;
use MagmaCore\Datatable\AbstractDatatableColumn;

class RoleColumn extends AbstractDatatableColumn
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
                    return '<input type="checkbox" class="uk-checkbox" id="roles" name="id[]" value="' . $row['id'] . '" onclick="CheckUncheckHeader()">';
                }
            ],
            [
                'db_row' => 'role_name',
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
                    $html .= $row["role_name"] . "<br/>";
                    $html .= '<div class="uk-text-truncate uk-width-3-4"><small>' . $row["role_description"] . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';

                    return $html;
                }
            ],
            [
                'db_row' => 'role_description',
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
                'dt_row' => 'Last Updated',
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
                'dt_row' => '',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function ($row, $twigExt) {
                    return $twigExt->action(
                        [
                            'has_permission' => $this->hasPermission($row),
                            'edit_modal' => [
                                'icon' => 'ion-compose',
                                'tooltip' => 'Edit',
                                'toggle_modal_edit' => true,
                                'callback' => function ($row, $twigExt) {
                                    return $twigExt->getModal(
                                        [
                                            'toggle_id' => 'edit-modal-role-' . $row['id'],
                                            'modal_title' => 'Edit ' . $row['role_name'],
                                            'modal_content' => (new RoleForm())
                                                ->createForm("/admin/role/{$row['id']}/edit", $row)
                                        ]
                                    );
                                }
                            ],
                            'trash' => ['tooltip' => 'Trash', 'icon' => 'ion-ios-trash']
                        ],
                        $row,
                        $twigExt,
                        'role',
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['role_name']}</strong> role."
                    );
                }
            ],

        ];
    }

    /**
     * Undocumented function
     *
     * @param array $row
     * @return array
     */
    private function hasPermission(array $row): array
    {
        $rolePerm = (new RolePermissionModel())
            ->getRepo()
            ->findOneBy(['role_id' => $row['id']]);
        if ($rolePerm != null) {
            $array = ['icon' => 'ion-locked', 'tooltip' => 'Role Lock', 'path' => "/admin/role/{$row['id']}/assigned", 'color' => 'uk-text-success'];
        } else {
            $array = ['icon' => 'ion-unlocked', 'tooltip' => 'Role Unlock', 'path' => "/admin/role/{$row['id']}/assigned", 'color' => 'uk-text-warning'];
        }
        return $array;
    }
}
