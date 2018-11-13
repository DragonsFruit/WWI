<?php
	class Search {
		/* @var DB */
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductsWith($name, $categoryId) {
			//stockitemid moet uiteindelijk variabel zijn
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.SearchDetails,                  SI.RecommendedRetailPrice, SI.Photo
										  FROM stockitems SI
										  JOIN stockitemstockgroups SIG
									      ON SI.StockItemID = SIG.StockItemID
										  JOIN stockgroups SG
										  ON SIG.StockGroupID = SG.StockGroupID
										  WHERE SI.StockItemName LIKE '%$name%'";
			if ($categoryId != 0) {
				$sql .= " AND SG.StockGroupID = '$categoryId'";
			}

			$sql .= " GROUP BY SI.StockItemID LIMIT 5";

			$result = $this->db->run($sql)->fetchAll();
			$this->data = $result;
		}
	}
