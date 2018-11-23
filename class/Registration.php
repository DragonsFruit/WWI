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

		public function registerUserPassword($email, $wachtwoord, $voornaam, $achternaam, $postcode, $straat, $huisnummer, $stad) { 
			$hash = password_hash($wachtwoord, PASSWORD_ARGON2I);
			$sql = "INSERT INTO useraccounts(email, wachtwoord, voornaam, achternaam, postcode, straat, huisnummer, stad)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			$this->db->run($sql, [$email, $hash, $voornaam, $achternaam, $postcode, $straat, $huisnummer, $stad]);
		}
	}

/* CREATE TABLE useraccounts (
userid int NOT NULL,
email varchar(45) NOT NULL,
wachtwoord varchar(45) NOT NULL,
voornaam varchar(45) NOT NULL,
achternaam varchar(45) NOT NULL,
gebdatum date NOT NULL,
postcode varchar(45) NOT NULL,
straat varchar(45) NOT NULL,
huisnummer int NOT NULL,
stad varchar(45) NOT NULL,
PRIMARY KEY(UserID)) */ 