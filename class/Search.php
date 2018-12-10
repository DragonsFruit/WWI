<?php
	class Search {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductsWith($name, $categoryId) {
			$name = '%' . $name . '%';

			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.SearchDetails, SI.RecommendedRetailPrice, SI.Photo
				    FROM stockitems SI
				    JOIN stockitemstockgroups SIG
			        ON SI.StockItemID = SIG.StockItemID
				    JOIN stockgroups SG
				    ON SIG.StockGroupID = SG.StockGroupID
				    WHERE SI.StockItemName LIKE ?";

			if ($categoryId != 0) {
				$sql .= " AND SG.StockGroupID = ? GROUP BY SI.StockItemID LIMIT 5";
				$result = $this->db->run($sql, [$name, $categoryId])->fetchAll();
			} else {
				$sql    .= " GROUP BY SI.StockItemID LIMIT 5";
				$result = $this->db->run($sql, [$name])->fetchAll();
			}

			$this->data = $result;
		}
	}
