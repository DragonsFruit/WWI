<?php
	// include "DB.php";

	class Registration {
		/* @var DB */
		protected $db;

        public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function registerUserWith($firstName,$lastName,$postCode,$houseNumber,$streetName,$country) {
				$sql = "INSERT INTO customers(CustomerID,CustomerName,CustomerCategoryID,PrimaryContactPersonID,deliverymethodID,DeliveryCityID,PostalCityID,LastEditedBy)
				VALUES (@Rows,?,?,?,?,?,?,?)";
				$this->db->run("set @Rows= (SELECT COUNT(*) FROM customers);");
				$this->db->run($sql, [$firstName . " " . $lastName, 1, 1, 1, 1, 1, 1]);
				
				// $sql = "INSERT INTO customers(CustomerName,CustomerCategoryID,PrimaryContactPersonID,deliverymethodID,DeliveryCityID,PostalCityID,LastEditedBy)
                // VALUES (?,?,?,?,?,?,?)";
                // $this->db->run($sql, [$firstName . " " . $lastName, 1, 1, 1, 1, 1, 1]);
			
		}
	}
