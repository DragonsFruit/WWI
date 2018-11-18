<?php 
    session_start();

    $id = $_POST["id"];
    $name = $_POST["name"];

    $newPrice = $_POST["price"];
    $oldPrice = $_SESSION["cart"][$id]["product_price"];
	$price = $oldPrice + $newPrice;

    $newQuantity = $_POST["quantity"];
	$oldQuantity =  $_SESSION["cart"][$id]["product_quantity"];
	$quantity = $oldQuantity + $newQuantity;

	// Products
    $product = [
        "product_id" => $id,
        "product_name" => $name,
        "product_price" => $price,
        "product_quantity" => $quantity
    ];
    $_SESSION["cart"][$id] = $product;

    // Totals
	$oldTotalQuantity = $_SESSION["cart"]["misc"]["total_quantity"];
	// $totalQuantity = $oldTotalQuantity + $newQuantity;
	$totalQuantity = array_sum(array_column($_SESSION['cart'], 'product_quantity'));

	$oldTotalPrice = $_SESSION["cart"]["misc"]["total_price"];
	// $totalPrice = $oldTotalPrice + $newPrice;
	$totalPrice = array_sum(array_column($_SESSION['cart'], 'product_price'));

	$misc = [
		"total_quantity" => $totalQuantity,
		"total_price" => $totalPrice
	];
    $_SESSION["cart"]["misc"] = $misc;
