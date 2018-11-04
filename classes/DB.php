<?php

// Database informatie
$host = 'localhost';
$dbName = 'wideworldimporters';
$user = "root";
$pass = "";

try {
    $pdo = new PDO('mysql:host='.$host.';dbname='.$dbName, $user, $pass);

    $id = filter_input(INPUT_GET, "id", FILTER_SANITIZE_NUMBER_INT);

    if (!is_null($id) && is_numeric($id)) {
	    // Loop langs alle rijen
	    foreach($pdo->query('SELECT * FROM stockitems WHERE StockItemID='.$id) as $row) { //stockitemid moet uiteindelijk variabel zijn
	        // Haal kolommen uit de array en zet het om naar strings, deze worden in een variable geplaatst
	        $productNaam = $row['StockItemName'];
		    $productPrijs = $row['RecommendedRetailPrice'];
		    $productBtw = $row['TaxRate'];
	        $productBeschrijving = $row['MarketingComments'];
		    $productBezorgTijd = $row['LeadTimeDays'];
	        $blob = $row['Photo'];
	    }
	    $pdo = null;
	} else {
	    header('Location: product.php?id=1');
	    die();
    }
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
