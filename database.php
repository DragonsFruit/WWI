<?php

// Database informatie
$db = "mysql:host=localhost;dbname=wideworldimporters;port=3306";
$user = "root";
$pass = "";
$pdo = new PDO($db, $user, $pass);

// Voorbereiden
$id = ($_GET["id"]);
$stmt = $pdo->prepare("SELECT * FROM stockitems WHERE StockItemID=$id"); 

// Uitvoeren
$stmt->execute();

// Loop langs alle rijen
while ($row = $stmt->fetch()) {

// Haal kolommen uit de array en zet het om naar strings, deze worden in een variable geplaatst
$productNaam = "{$row['StockItemName']}";
$productPrijs = "{$row['RecommendedRetailPrice']}";
$productBeschrijving = "{$row['MarketingComments']}";
$blob = $row['Photo'];
}

$pdo = NULL;
