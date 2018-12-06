<?php
	class Invoice {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function createInvoiceFor($customerId, $invoiceDate, $totalItems, $deliveryTime) {
			$sql = "INSERT INTO invoices(CustomerID, BillToCustomerID, InvoiceDate, CustomerPurchaseOrderNumber, TotalDryItems, ConfirmedDeliveryTime, LastEditedWhen)
			SELECT ?, ?, ?, count(*)+1, ?, ?, CURRENT_TIMESTAMP
			FROM invoices
			WHERE CustomerID = ?";
			$this->db->run($sql, [$customerId, $customerId, $invoiceDate, $totalItems, $deliveryTime, $customerId]);
			$sql = null;

			$stockItems = $_SESSION["cart"];

			foreach ($stockItems as $stockItem) {
				if ($stockItem != $stockItems["misc"]) {
					$sql = "INSERT INTO invoicelines(InvoiceID, StockItemID, Description, Quantity)
					SELECT i.InvoiceID,?,?,?
					FROM invoices i
					WHERE CustomerID = ?";
					$this->db->run($sql, [$stockItem["product_id"], $stockItem["product_name"], $stockItem["product_quantity"], $_SESSION["user"]["user_id"]]);
					$sql = null;
				}
			}

			unset($_SESSION['cart']);
		}

		public function getInvoicesFor($userId) {
			$sql = "SELECT I.InvoiceID, I.InvoiceDate, I.CustomerPurchaseOrderNumber, I.ConfirmedDeliveryTime, I.ConfirmedReceivedBy, IL.Description, IL.Quantity, S.RecommendedRetailPrice
					FROM invoices I
					JOIN invoicelines IL ON I.InvoiceID = IL.InvoiceID
					JOIN stockitems S ON IL.StockItemID = S.StockItemID
					WHERE I.CustomerID = ?
					ORDER BY I.InvoiceDate";
			$result = $this->db->run($sql, [$userId])->fetchAll();
			$this->data = $result;
		}
	}
