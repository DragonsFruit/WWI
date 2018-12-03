<?php
	class Login {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
        }
        
        public function login($inputUsername, $inputPassword) {
            try {
                $sql = "SELECT * FROM useraccounts WHERE email = ?";
                $result = $this->db->run($sql, [$inputUsername])->fetch(PDO::FETCH_ASSOC);
                if (password_verify($inputPassword, $result['wachtwoord'])) {
                	session_start();
                    $_SESSION['user']['username'] = $result["voornaam"];
                }
            } catch (PDOException $e) {
                echo 'Login error: ' . $e->getMessage();
            }
        }

		public function isLoggedIn() {
			if(isset($_SESSION['user'])) {
				return true;
			}
			return false;
		}
	}
