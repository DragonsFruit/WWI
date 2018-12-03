<?php
	class Category {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getCategories() {
			$result = $this->db->run("SELECT SG.StockGroupID, SG.StockGroupName
										  FROM stockgroups SG
										  JOIN stockitemstockgroups s on SG.StockGroupID = s.StockGroupID
										  WHERE s.StockGroupID = SG.StockGroupID
										  GROUP BY s.StockGroupID
										  ORDER BY StockGroupName ASC")->fetchAll();
			$this->data = $result;
		}
	}
