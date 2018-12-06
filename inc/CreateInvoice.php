<?php
	include_once "Autoload.php";
    session_start();

    $userId = $_POST["userId"];
    $invoiceDate = $_POST["invoiceDate"];
    $totalItems = $_POST["totalItems"];
	$deliveryTime = $_POST["deliveryTime"];

	// Create the invoice
	$invoice = new Invoice();
	$invoice->createInvoiceFor($userId, $invoiceDate, $totalItems, $deliveryTime);
