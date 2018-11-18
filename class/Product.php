<?php
	include "DB.php";

	class Product {
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

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductDetailsWithId($id) {
			//stockitemid moet uiteindelijk variabel zijn
			foreach($this->db->run("SELECT * FROM stockitems WHERE StockItemID = ?", [$id]) as $row) {
				$this->productName = $row['StockItemName'];
				$this->productPrice = $row['RecommendedRetailPrice'];
				$this->productTaxRate = $row['TaxRate'];
				$this->productDescription = $row['MarketingComments'];
			    $this->productLeadTimeDays = $row['LeadTimeDays'];
			    $this->productWeight = $row['TypicalWeightPerUnit'];
			    $this->productBrand = $row['Brand'];
			    $this->productSize = $row['Size'];
			    $this->productTags = $row['Tags'];
			    $this->productPhoto = $row['Photo'];
			}
		}
	}
