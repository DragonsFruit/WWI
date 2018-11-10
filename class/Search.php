<?php
	include "DB.php";

	class Search {
		/* @var DB */
		protected $db;

		public $productName;
		public $productPrice;
		public $productTaxRate;
		public $productDescription;
		public $productLeadTimeDays;
		public $productWeight;
		public $productBrand;
		public $productSize;
		public $productTags;
		public $productPhoto;
		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductsWithName($name) {
			//stockitemid moet uiteindelijk variabel zijn
			$result = $this->db->run("SELECT * FROM stockitems WHERE StockItemName LIKE '%$name%' LIMIT 5")->fetchAll();
			$this->data = $result;
		}
	}
