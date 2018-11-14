<?php
	class Productlist {
		/* @var DB */
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function getProductlist() {
			$result = $this->db->run("SELECT * FROM stockitems")->fetchAll();
			$this->data = $result;
		}
	}
