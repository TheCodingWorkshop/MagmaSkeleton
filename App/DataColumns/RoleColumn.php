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

class RoleColumn extends AbstractDatatableColumn
{

    public function columns(): array
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
                    return $twigExt->iconNav(
                        [
                            'file-edit' => [],
                            'trash' => ['tooltip' => 'Trash', 'icon' => 'trash']
                        ],
                        $row,
                        'role',
                        false
                    );
                }
            ],

        ];
    }
}
