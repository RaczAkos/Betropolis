<?php

require_once("../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database('betropolis');

$checkBalanceQuery = "SELECT balance FROM users WHERE id = ?";

$oldBalance = db->execute($checkBalanceQuery, $args['id']);

$newBalance = $oldBalance . $args['balance'];

$updateBalanceQuery = "UPDATE users SET balance = ? WHERE id = ?";

$result = db->execute($updateBalanceQuery, [$newBalance, $args['id']]);

Util::setResponse($newBalance);