<?php
    // Load classes
    include_once "inc/autoload.php";

	// Set current page active
    $currentPage = 'login';
    
    $headerTitle = "Login";

	include "inc/header.php";

	if (isset($_POST["email"]) && isset($_POST["wachtwoord"])) {
		$login = new Login();
		$inputUsername = $_POST['email'];
		$inputPassword = $_POST['wachtwoord'];
		$login->login($inputUsername, $inputPassword);
	}
?>

<main>
    <div class="container">
	    <form class="form-signin" method="POST">
	        <h2 class="form-signin-heading">Log in</h2><br>
	        <input type="email" id="inputEmail" class="form-control" name="email" placeholder="Email address" required autofocus>
	        <input type="password" id="loginInputPassword" class="form-control" name="wachtwoord" placeholder="Password" required>
	        <br><div class="checkbox">
	            <input type="checkbox" value="remember-me"> Remember me
	        </div>
	        <br><a href="registery.php">No account? Register here</a><br>
	        <br><button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
	    </form>
    </div>
</main>

<?php 
    include "inc/footer.php";
?>
