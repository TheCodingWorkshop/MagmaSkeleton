<?php
require inc.php;

use MagmaCore\Migration\Driver\MigrationMysql;

$migrations = new MigrationMysql();
$migrations->migrate('down');

// int $Boiler1HighTemp;
// int $Boiler2HighTemp;
// int $Boiler3HighTemp;
// int $Boiler1LockOut;
// int $Boiler2LockOut;
// int $Boiler3LockOut;
// int $CTPumpsFlow; // status value
// int $PressureUnitFault; // status value
// int $Boiler1Fault = false;
// int $Boiler2Fault = false;
// int $Boiler3Fault = false;
//
// if (!function_exists('checkBoilerFaults')) {
//   function checkBoilerFaults(int $highTemp = 0, int $fault = false, int $lockOut = false, $PressureUnitFault, $CTPumpsFlow) {
//     if ($highTemp OR $lockOut OR $fault OR $PressureUnitFault OR NOT $CTPumpsFlow) {
//       $fault = true;
//     } else {
//       $fault = false;
//     }
//
//     return $fault;
//   }
//
// }
//
// /** Check all 3 boilers for fault */
// checkBoilerFaults($Boiler1HighTemp, $Boiler1Fault, $Boiler1LockOut, $PressureUnitFault, $CTPumpsFlow);
// checkBoilerFaults($Boiler2HighTemp, $Boiler2Fault, $Boiler2LockOut, $PressureUnitFault, $CTPumpsFlow);
// checkBoilerFaults($Boiler3HighTemp, $Boiler3Fault, $Boiler3LockOut, $PressureUnitFault, $CTPumpsFlow);
//
//
// Boiler4:
//   if not BoilersRequired then goto NotRequired
// BoilerAlarm = 4;
//   Bpid(1, 3, BoilerFlowTemp, BoilerFlowTempSetpoint, Kp, Ki, Kd, Db, LoopOp, Bias, ISum, Err, Ltim)
