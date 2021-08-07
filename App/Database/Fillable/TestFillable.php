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

namespace App\Database\Fillable;;

use App\Model\TestModel;
use MagmaCore\Fillable\FillableSchema;
use MagmaCore\Fillable\FillableSchemaInterface;

class TestFillable extends FillableSchema implements FillableSchemaInterface
{
   
    /** @var FillableSchema $fillable */
    private FillableSchema $fillable;
    /** @var TestModel $testModel; */
     private TestModel $testModel;

    /**
     * Main constructor class. Any typed hinted dependencies will be autowired. As this 
     * class can be inserted inside a dependency container
     *
     * @param FillableSchema $fillable
     * @param FillableBlueprint $blueprint
     * @param TestModel $testModel
     * @return void
     */
    public function __construct(FillableSchema $fillable, TestModel $testModel)
    {
        $this->fillable = $fillable;
        $this->testModel = $testModel;
    }

    /**
     * @return string
     */
    public function createFillable(): string
    {
        $this->fillable->create(1, function($fillable){
            return $fillable
            ->table($this->testModel)
            ->fill($fillable->faker()->email)
            ->bind(function ($fillable) {
                return $fillable
                    ->on($fillable->getModel()->getFillables(TestModel::class))
                    ->push();
            });

        });
            
    }
}
