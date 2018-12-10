<?php
	class ProductList {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductListBy($categoryId, $recordsFrom, $recordsPerPage) {
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.RecommendedRetailPrice, SI.MarketingComments, SI.Photo
					FROM stockitems SI
					JOIN stockitemstockgroups SIG
					ON SI.StockItemID = SIG.StockItemID
					JOIN stockgroups SG
					ON SIG.StockGroupID = SG.StockGroupID";

			if ($categoryId != 0) {
				$sql .= " WHERE SG.StockGroupID = ?";
				$result = $this->db->run($sql, [$categoryId])->fetchAll();
			} else {
				$sql .= " GROUP BY SI.StockItemID LIMIT ?, ?";
				$result = $this->db->run($sql, [$recordsFrom, $recordsPerPage])->fetchAll();
			}

			$this->data = $result;
		}

		public function getProducts() {
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.RecommendedRetailPrice, SI.MarketingComments, SI.Photo
					FROM stockitems SI
					JOIN stockitemstockgroups SIG
					ON SI.StockItemID = SIG.StockItemID
					JOIN stockgroups SG
					ON SIG.StockGroupID = SG.StockGroupID
					GROUP BY SI.StockItemID LIMIT 10";

			$result = $this->db->run($sql)->fetchAll();
			$this->data = $result;
		}

		public function getProductsUnder($price) {
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.RecommendedRetailPrice, SI.MarketingComments, SI.Photo
					FROM stockitems SI
					JOIN stockitemstockgroups SIG
					ON SI.StockItemID = SIG.StockItemID
					JOIN stockgroups SG
					ON SIG.StockGroupID = SG.StockGroupID 
					WHERE SI.RecommendedRetailPrice < ? 
					GROUP BY SI.StockItemID LIMIT 5";

			$result = $this->db->run($sql, [$price])->fetchAll();
			$this->data = $result;
		}

		public function getProductsWithDeals($price) {
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.RecommendedRetailPrice, SI.MarketingComments, SI.Photo
					FROM stockitems SI
					JOIN stockitemstockgroups SIG
					ON SI.StockItemID = SIG.StockItemID
					JOIN stockgroups SG
					ON SIG.StockGroupID = SG.StockGroupID 
					WHERE SI.RecommendedRetailPrice < ? 
					GROUP BY SI.StockItemID LIMIT 5";

			$result = $this->db->run($sql, [$price])->fetchAll();
			$this->data = $result;
		}

	}
