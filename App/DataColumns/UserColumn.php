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
                'dt_row' => "",
                'class' => 'id-class',
                'show_column' => true,
                'sortable' => false,
                'formatter' => function($row) {
                    return '<input type="checkbox" class="uk-checkbox">';
                }
            ],
            [
                'db_row' => 'firstname',
                'dt_row' => 'Firstname',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'formatter' => function($row) {
                    return $row['firstname'] . ' ' . $row['lastname'];
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
                'show_column' => true,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'status',
                'dt_row' => 'Status',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'formatter' => ''
            ],
            [
                'db_row' => 'created_at',
                'dt_row' => 'Published',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'formatter' => ''
            ],
            [
                'db_row' => 'modified_at',
                'dt_row' => 'Modified',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
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
                'dt_row' => 'IP Address',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'formatter' => ''
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
                            'user' => [],
                            'trash' => []
                        ],
                        $row,
                        'user',
                        false
                    );
                }
            ],

        ];
    }
}