<?php
	class Invoice {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function createInvoiceFor($customerId, $invoiceDate, $totalItems, $deliveryTime) {
			$sql = "INSERT INTO invoices(CustomerID, BillToCustomerID, InvoiceDate, TotalDryItems, ConfirmedDeliveryTime, CustomerPurchaseOrderNumber)
			VALUES (?, ?, ?, ?, ?)";
			$this->db->run($sql, [$customerId, $customerId, $invoiceDate, $totalItems, $deliveryTime]);
		}

		public function getInvoicesFor($userId) {
			$sql = "SELECT I.InvoiceID, I.InvoiceDate, I.CustomerPurchaseOrderNumber, I.TotalDryItems, I.ConfirmedDeliveryTime, I.ConfirmedReceivedBy
					FROM invoices I
					WHERE I.CustomerID = ?
					ORDER BY I.InvoiceDate";
			$result = $this->db->run($sql, [$userId])->fetchAll();
			$this->data = $result;
		}
	}
