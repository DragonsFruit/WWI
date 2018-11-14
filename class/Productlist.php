<?php
	class Productlist {
		/* @var DB */
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductlistBy($categoryId) {
			$sql = "SELECT SI.StockItemID, SI.StockItemName, SI.RecommendedRetailPrice, SI.MarketingComments, SI.Photo
					FROM stockitems SI
					JOIN stockitemstockgroups SIG
					ON SI.StockItemID = SIG.StockItemID
					JOIN stockgroups SG
					ON SIG.StockGroupID = SG.StockGroupID";

			if ($categoryId != 0) {
				$sql .= " WHERE SG.StockGroupID = '$categoryId'";
			}
			$sql .= " GROUP BY SI.StockItemID";
			
			$result = $this->db->run($sql)->fetchAll();
			$this->data=$result;
		}
	}
