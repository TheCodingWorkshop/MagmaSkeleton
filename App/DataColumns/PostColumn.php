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

use MagmaCore\UserManager\PostModel;
use MagmaCore\Datatable\AbstractDatatableColumn;

class PostColumn extends AbstractDatatableColumn
{

    private PostModel $userModel;

    public function __construct(PostModel $postModel)
    {
        $this->postModel = $postModel;
    }

    private string $controller = 'post';

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
                'db_row' => 'title',
                'dt_row' => 'Title',
                'class' => '',
                'show_column' => true,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    // $data = $this->userModel->getUser($row['user_id']);
                    // $html = '<div class="uk-grid-small uk-flex-middle" uk-grid>';
                    // $html .= '<div class="uk-width-auto">';
                    // $html .= '<img class="uk-border-circle" width="40" height="40" src="' . $data->gravatar . '">';
                    // $html .= '</div>';

                    // $html .= ' <div class="uk-width-expand">';
                    // $html .= '<div class="uk-clearfix">';
                    // $html .= '<div class="uk-float-left uk-text-small">';
                    // $html .= $data->firstname . ' ' . $data->lastname . ' - ' . $this->truncate($row['subject'], 50, 30);
                    // $html .= '</div>';
                    // $html .= '<div class="uk-float-right">';
                    // $html .= $this->messageActions($row, $tempExt);
                    // $html .= '</div>';

                    // $html .= '</div>';
                    // $html .= '<p class="uk-text-meta uk-margin-remove-top uk-text-truncate"><a class="uk-text-link uk-link-reset" href="/admin/message/' . $row['id'] . '/show?user=' . $row['user_id'] . '">' . $this->truncate($row['body']) . '</a></p>
                    //     ';
                    // $html .= '</div>';

                    // return $html;
                }
            ],
            [
                'db_row' => 'slug',
                'dt_row' => 'Slug',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['slug'] ?? 'None';
                }
            ],
            [
                'db_row' => 'url',
                'dt_row' => 'Url',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['url'] ?? 'None';
                }
            ],
            [
                'db_row' => 'article',
                'dt_row' => 'Article',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['article'] ?? 'None';
                }
            ],
            [
                'db_row' => 'summary',
                'dt_row' => 'Summary',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['summary'] ?? 'None';
                }
            ],
            [
                'db_row' => 'status',
                'dt_row' => 'Status',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['status'] ?? 'None';
                }
            ],
            [
                'db_row' => 'author',
                'dt_row' => 'Author',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => true,
                'formatter' => function ($row, $tempExt) {
                    return $row['author'] ?? 'None';
                }
            ],
            [
                'db_row' => 'created_at',
                'dt_row' => 'Published',
                'class' => '',
                'show_column' => false,
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
                'dt_row' => 'Modified',
                'class' => '',
                'show_column' => false,
                'sortable' => true,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    $html = $tempExt->tableDateFormat($row, "modified_at", true);
                    $html .= '<div><small>By Admin</small></div>';
                    return $html;
                }
            ],
            [
                'db_row' => '',
                'dt_row' => 'Action',
                'class' => '',
                'show_column' => false,
                'sortable' => false,
                'searchable' => false,
                'formatter' => function ($row, $tempExt) {
                    return $tempExt->action(
                        [
                            'archive' => ['tooltip' => 'Archive', 'icon' => 'ion-archive'],
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


    public function truncate(string $str, int $max = 100, int $min = 80)
    {
        if (strlen($str) > $max)
            $str = substr($str, 0, $min) . ' ...';

        return $str;
    }
}
