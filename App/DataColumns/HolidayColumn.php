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
use App\Model\HolidayModel;

class HolidayColumn extends AbstractDatatableColumn
{

    use DataColumnTrait;

    private HolidayModel $hollidayModel;

    private string $controller = 'holiday';

    public function __construct(HolidayModel $hollidayModel)
    {
        $this->hollidayModel = $hollidayModel;
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
                    return '<input type="checkbox" class="uk-checkbox" id="holidays-' . $row['id'] . '" name="id[]" value="' . $row['id'] . '">';
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
                    $html .= '<a href="' . ($isActive ? '/admin/holiday/' . $row['id'] . '/deactive' : '/admin/holiday/' . $row['id'] . '/active') . '">';
                    $html .= '<span uk-tooltip="' . ($isActive ? 'Click to De-activate Holiday' : 'Click to Activate Holiday') . '">' . ($isActive ? '<ion-icon name="checkmark-outline"></ion-icon>' : '<ion-icon name="close-outline"></ion-icon>') . '</span>';
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
                'db_row' => 'holiday_date',
                'dt_row' => 'Date <sup class="uk-text-small uk-text-danger uk-text-bolder">(' . date('Y') . ')</sup>',
                'class' => '',
                'show_column' => true,
                'sortable' => false,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) use ($callingController) {
                    /* Substitue days are days given as substitute days when the corresponding holiday falls on a weekend */
                    $christmasDay = 'Dec 25th';
                    $boxingDay = 'Dec 26th';
                    $newYearsDay = 'Jan 1st';
                    if (
                        $row['name'] == 'Christmas Day' && $row['holiday_date'] !== $christmasDay ||
                        $row['name'] == 'Boxing Day' && $row['holiday_date'] !== $boxingDay || 
                        $row['name'] == 'New Years Day' && $row['holiday_date'] !== $newYearsDay) {
                            return $row['holiday_date'] . ' <span uk-tooltip="Holiday falls on a weekend. So is substituted for the following date" class="uk-text-meta uk-text-primary">(Substitute Day)</span>';
                    } else {
                        return $row['holiday_date'] ?? 'None';
                    }
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
                        "You are about to carry out an irreversable action. Are you sure you want to delete <strong class=\"uk-text-danger\">{$row['name']}</strong> category."
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
