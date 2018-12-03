<?php
    // Load classes
    include_once "inc/autoload.php";

	// Set current page active
    $currentPage = 'login';
    
    $headerTitle = "Login";

	if (isset($_POST["email"]) && isset($_POST["password"])) {
		$login = new Login();
		$inputUsername = $_POST['email'];
		$inputPassword = $_POST['password'];
		$login->login($inputUsername, $inputPassword);
	}
	include "inc/header.php";

	var_dump($_SESSION);
?>

<main>
    <div class="container">
	    <form class="form-signin" method="POST">
	        <h2 class="form-signin-heading">Log in</h2><br>
	        <input type="email" id="inputEmail" class="form-control" name="email" placeholder="Your wonderful email address..." required autofocus>
	        <input type="password" id="loginInputPassword" class="form-control" name="password" placeholder="Your super secret password..." required>
	        <br>
		    <a href="registry.php">No account? Register here</a>
		    <br>
	        <br>
		    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	    </form>
    </div>
</main>

<?php 
    include "inc/footer.php";
?>
