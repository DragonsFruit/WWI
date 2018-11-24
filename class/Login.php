<?php
	class Login {
		protected $db;

		public $data;

		public function __construct() {
			$this->db = DB::instance();
        }
        
        public function loginUser($userPassword, $inputUsername) {
            $sql = "SELECT Wachtwoord FROM useraccounts WHERE Email = $inputUsername";
            $result = $this->db->run($sql)->fetchAll();
            if (password_verify($inputPassword, $result)) {
                $_SESSION['user'] = $inputUsername;
            }
        }
	}