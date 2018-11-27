<?php
	class Login {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
        }
        
        public function loginUser($inputPassword, $inputUsername) {
            try {
                $sql = "SELECT * FROM useraccounts WHERE Email = ?";
                $result = $this->db->run($sql, [$inputUsername])->fetch(PDO::FETCH_ASSOC);
                if (password_verify($inputPassword, $result['Wachtwoord'])) {
                    $_SESSION['user'] = $inputUsername;
                }
            } catch (PDOException $e) {
                echo 'Database error: ' . $e->getMessage();
            }
        }
	}