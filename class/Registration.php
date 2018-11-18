<?php
	class Registration {
		protected $db;

        public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function registerUserWith($firstName, $lastName, $postCode, $houseNumber, $streetName, $city) {
			$name = $firstName . " " . $lastName;
			$sql = "INSERT INTO customers(CustomerID, CustomerName, CustomerCategoryID, PrimaryContactPersonID, DeliveryMethodID, DeliveryCityID, PostalCityID, LastEditedBy)
			VALUES (@Rows, ?, ?, ?, ?, ?, ?, ?)";

			$this->db->run("SET @Rows= (SELECT COUNT(*) FROM customers)");
			$this->db->run($sql, [$name, 1, 1, 1, 1, 1, 1]);
		}
	}
