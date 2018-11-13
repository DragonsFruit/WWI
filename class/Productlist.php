<?php
	class Productlist {
		/* @var DB */
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductlist() {
			$result = $this->db->run("SELECT SI.StockItemID, SI.StockItemName, SI.SearchDetails,                  SI.RecommendedRetailPrice, SI.Photo
                                        FROM stockitems SI
                                        JOIN stockitemstockgroups SIG
                                        ON SI.StockItemID = SIG.StockItemID
                                        JOIN stockgroups SG
                                        ON SIG.StockGroupID = SG.StockGroupID
                                        WHERE SI.StockItemName LIKE '%$name%'")->fetchAll();
			$this->data = $result;
		}
	}
