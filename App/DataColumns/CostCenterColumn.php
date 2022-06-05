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

use MagmaCore\Datatable\DataColumnTrait;
use MagmaCore\Datatable\AbstractDatatableColumn;
use App\Model\CostCenterModel;

class CostCenterColumn extends AbstractDatatableColumn
{

    use DataColumnTrait;

    private CostCenterModel $costCenterModel;

    private string $controller = 'costCenter';

    public function __construct(CostCenterModel $costCenterModel)
    {
        $this->costCenterModel = $costCenterModel;
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
                    return '<input type="checkbox" class="uk-checkbox" id="costcenters-' . $row['id'] . '" name="id[]" value="' . $row['id'] . '">';
                }
            ],
            [
                'db_row' => 'name',
                'dt_row' => 'Name',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    $isActive = $row['status'] === 'active';
                    $html = '<div class="uk-clearfix">';
                    $html .= '<div class="uk-float-left uk-margin-small-right">';
                    $html .= '<span class="uk-text-primary">';
                    $html .= '<a href="' . ($isActive ? '/admin/costCenter/' . $row['id'] . '/deactive' : '/admin/costCenter/' . $row['id'] . '/active') . '">';
                    $html .= '<span uk-tooltip="' . ($isActive ? 'Click to De-activate costCenter' : 'Click to Activate costCenter') . '">' . ($isActive ? '<ion-icon name="checkmark-outline"></ion-icon>' : '<ion-icon name="close-outline"></ion-icon>') . '</span>';
                    $html .= '</a>';
                    $html .= '</span>';
                    $html .= '<div>';
                    $html .= '</div>';
                    $html .= '<div>';
                    $html .= '<span class="uk-text-primary"><ion-icon name="information-circle-outline"></ion-icon></span>';
                    $html .= '</div>';
                    $html .= '</div>';
                    $html .= '<div class="uk-float-left">';
                    $html .= $row["name"] . "<br/>";
                    $html .= '<div class="uk-text-truncate uk-width-3-4"><small>' . $this->truncate($row['description'], 100, 70) . '</small></div>';
                    $html .= '</div>';
                    $html .= '</div>';

                    return $html;

                }
            ],
            [
                'db_row' => 'slug',
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
                'db_row' => 'code',
                'dt_row' => 'Code',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['code'] ?? 'None';
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
                            'more' => [
                                'icon' => 'more',
                                'callback' => function ($row, $tempExt) {
                                    return $tempExt->getDropdown(
                                        $this->columnActions($row, $this->controller, $tempExt),
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
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['name']}</strong> cost center."
                    );
                }
            ],

        ];
    }

    /**
     * @inheritDoc
     *
     * @param array $row
     * @param string|null $controller
     * @param object|null $tempExt
     * @return array
     */
    public function columnActions(array $row = [], ?string $controller = null, ?object $tempExt = null): array
    {
        return $this->filterColumnActions(
            $row, 
            $this->columnBasicLinks($this), /* can merge additional links here to this column */
            $controller
        );
    }


}
