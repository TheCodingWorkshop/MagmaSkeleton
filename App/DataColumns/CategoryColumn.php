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

use App\Model\CategoryModel;
use MagmaCore\Datatable\DataColumnTrait;
use App\Forms\Admin\Category\CategoryForm;
use MagmaCore\Datatable\AbstractDatatableColumn;

class CategoryColumn extends AbstractDatatableColumn
{

    use DataColumnTrait;

    private CategoryModel $categoryModel;
    private CategoryForm $form;

    private string $controller = 'category';

    public function __construct(CategoryModel $categoryModel, CategoryForm $form)
    {
        $this->CategoryModel = $categoryModel;
        $this->form = $form;
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
                'db_row' => 'cat_name',
                'dt_row' => 'Name',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    $html = '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left uk-margin-small-right">';
                    $html .= '<div>';
                    // $expiration = $this->roleOnExpiration(['current_role_id' => $row['id']]);
                    // if (isset($expiration->current_role_id) && $expiration->current_role_id !==null) {
                    //     $html .= '<span uk-tooltip="Expiration Set"><ion-icon name="time-outline"></ion-icon></span>';
                    // }

                    $html .= '</div>';
                    $html .= '<div>';
                    $html .= '<span class="uk-text-primary"><ion-icon name="information-circle-outline"></ion-icon></span>';
                    $html .= '</div>';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left">';
                    $html .= $row["cat_name"] . "<br/>";
                    $html .= '<div class="uk-text-truncate uk-width-3-4"><small>' . $row["role_description"] . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';

                    return $html;

                }
            ],
            [
                'db_row' => 'cat_slug',
                'dt_row' => 'Slug',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['status'] ?? 'None';
                }
            ],
            [
                'db_row' => 'cat_parent',
                'dt_row' => 'Parent',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    return $row['cat_parent'] ?? 0;
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
                'show_column' => true,
                'sortable' => true,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    $html = $tempExt->tableDateFormat($row, "created_at", true);
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
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    $html = '';
                    if (isset($row["modified_at"]) && $row["modified_at"] != null) {
                        $html .= $tempExt->tableDateFormat($row, "modified_at");
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
                'formatter' => function ($row, $tempExt) {
                    return $tempExt->action(
                        [
                            // 'edit_modal' => [
                            //     'icon' => 'create-outline',
                            //     'tooltip' => 'Edit',
                            //     'toggle_modal_edit' => true,
                            //     'callback' => function($row, $tempExt) {
                            //         return $tempExt->getModal(
                            //             [
                            //                 'toggle_id' => 'edit-modal-category-' . $row['id'],
                            //                 'modal_title' => 'Edit [' . $row['cat_name'] . ']' ,
                            //                 'modal_content' => $this->form
                            //                 ->createForm(
                            //                     '/admin/category/' . $row['id'] . '/edit', 
                            //                     $row
                            //                 )
                            //             ]
                            //         );
                            //     }
                            // ],
                            // 'trash' => ['tooltip' => 'Trash', 'icon' => 'trash']
                
                            'more' => [
                                'icon' => 'ion-more',
                                'callback' => function ($row, $tempExt) {
                                    return $tempExt->getDropdown(
                                        $this->itemsDropdown($row, $this->controller, $tempExt),
                                        $this->getDropdownStatus($row),
                                        $row,
                                        $this->controller,
                                        ['basic_access']
                                    );
                                }
                            ],
                        ],
                        $row,
                        $tempExt,
                        $this->controller,
                        false,
                        'Are You Sure!',
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['subject']}</strong> role."
                    );
                }
            ],

        ];
    }

    /**
     * Undocumented function
     *
     * @param array $row
     * @param string $controller
     * @return array
     */
    private function itemsDropdown(array $row, string $controller, $tempExt): array
    {
        $items = [
            'edit' => ['name' => 'edit', 'icon' => 'create-outline'],
            'trash' => ['name' => 'trash account', 'icon' => 'trash-bin-outline']
        ];
        return array_map(
            fn($key, $value) => array_merge(['path' => $this->adminPath($row, $controller, $key)], $value),
            array_keys($items),
            $items
        );
    }


}
