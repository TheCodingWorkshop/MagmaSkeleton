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

class ProjectColumn extends AbstractDatatableColumn
{
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
                'searchable' => true,
                'formatter' => function ($row) {
                    return '<input type="checkbox" class="uk-checkbox" id="projects-' . $row['id'] . '" name="id[]" value="' . $row['id'] . '">';
                }
            ],
            [
                'db_row' => 'coordinator',
                'dt_row' => 'Manager',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $twigExt) {
                    $html = '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left uk-margin-small-right">';
                    $html .= '<span class="uk-text-teal" uk-icon="icon: info"></span>';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left">';
                    $html .= $row["name"] . "<br/>";
                    $html .= '<div class=""><small>' . $row["coordinator"] . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';

                    return $html;
                }
            ],
            [
                'db_row' => 'type',
                'dt_row' => 'Type',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'name',
                'dt_row' => 'Name',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'client',
                'dt_row' => 'Client',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => ''
            ],
            [
                'db_row' => 'duration',
                'dt_row' => 'Duration',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],

            [
                'db_row' => 'cost',
                'dt_row' => 'Cost',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'status',
                'dt_row' => 'Status',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'location',
                'dt_row' => 'Location',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'description',
                'dt_row' => 'Description',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'created_byid',
                'dt_row' => 'Created By',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => ''
            ],

            [
                'db_row' => 'created_at',
                'dt_row' => 'Published',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => false,
                'formatter' => function ($row, $twigExt) {
                    $html = $twigExt->tableDateFormat($row, "created_at", true);
                    $html .= '<div><small>By Admin</small></div>';
                    return $html;
                }
            ],
            [
                'db_row' => 'modified_at',
                'dt_row' => 'Modified',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => function ($row, $twigExt) {
                    $html = '';
                    if (isset($row["modified_at"]) && $row["modified_at"] != null) {
                        $html .= $twigExt->tableDateFormat($row, "modified_at", true);
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
                'searchable' => false,
                'formatter' => function ($row, $twigExt) {
                    return $twigExt->action(
                        [
                            'file-edit' => ['tooltip' => 'Edit', 'icon' => 'ion-compose'],
                            'trash' => ['tooltip' => 'Trash', 'icon' => 'ion-ios-trash']
                        ],
                        $row,
                        $twigExt,
                        'project',
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['name']}</strong> role."
                    );
                }
            ],

        ];
    }
}
