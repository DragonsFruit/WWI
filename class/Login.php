<?php
	class Login {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
        }
        
        public function login($inputUsername, $inputPassword) {
            try {
                $sql = "SELECT * FROM useraccounts WHERE Email = ?";
                $result = $this->db->run($sql, [$inputUsername])->fetch(PDO::FETCH_ASSOC);
                if (password_verify($inputPassword, $result['Password'])) {
                	session_start();
                    $_SESSION['user']['username'] = $result["FirstName"];
	                $_SESSION['user']['user_id'] = $result["CustomerID"];
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
