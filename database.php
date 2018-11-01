<?php

$db = "mysql:host=localhost;dbname=wideworldimporters;port=3306";
$user = "root";
$pass = "";
$pdo = new PDO($db, $user, $pass);

// voorbereiden

$stmt = $pdo->prepare("SELECT * FROM stockitems WHERE StockItemID=1"); //stockitemid moet uiteindelijk variabel zijn

// uitvoeren
$stmt->execute();

// loop langs alle rijen
while ($row = $stmt->fetch()) {

    // haal de kolom ‘naam’ op
    $naam = $row["StockItemName"];
    $foto = $row["Photo"];
    $omschrijving = $row["MarketingComments"];
}

$pdo = NULL;
