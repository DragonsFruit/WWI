<?php

// Database informatie
$host = 'localhost';
$dbName = 'wideworldimporters';
$user = "root";
$pass = "";

try {
    $pdo = new PDO('mysql:host='.$host.';dbname='.$dbName, $user, $pass);

    // Loop langs alle rijen
    foreach($pdo->query('SELECT * FROM stockitems WHERE StockItemID=1') as $row) { //stockitemid moet uiteindelijk variabel zijn
        // Haal kolommen uit de array en zet het om naar strings, deze worden in een variable geplaatst
        $productNaam = "{$row['StockItemName']}";
        $productPrijs = "{$row['RecommendedRetailPrice']}";
        $productBeschrijving = "{$row['MarketingComments']}";
        $blob = $row['Photo'];
    }
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
