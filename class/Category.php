<?php
	class Category {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getCategories() {
			$result = $this->db->run("SELECT StockGroupID, StockGroupName FROM stockgroups ORDER BY StockGroupName ASC")->fetchAll();
			$this->data = $result;
		}
	}
