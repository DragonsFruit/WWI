<?php
	class Registration {
		protected $db;

        public $data;

		public function __construct() {
			$this->db = DB::instance();
		}

		public function registerUserWith($email, $wachtwoord, $voornaam, $achternaam, $postcode, $straat, $huisnummer, $stad) {
			$hash = password_hash($wachtwoord, PASSWORD_ARGON2I);
			$sql = "INSERT INTO useraccounts(Email, Password, FirstName, LastName, ZipCode, StreetName, Number, City)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			$this->db->run($sql, [$email, $hash, $voornaam, $achternaam, $postcode, $straat, $huisnummer, $stad]);
		}
	}

/* CREATE TABLE useraccounts (
CustomerID int NOT NULL auto_increment,
Email varchar(255) NOT NULL,
Password varchar(255) NOT NULL,
FirstName varchar(45) NOT NULL,
LastName varchar(45) NOT NULL,
ZipCode varchar(7) NOT NULL,
StreetName varchar(45) NOT NULL,
Number int NOT NULL,
City varchar(45) NOT NULL,
PRIMARY KEY(UserID)) */ 
