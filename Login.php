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
?>

<main>
    <div class="container bg-white py-3 border br-10">
	    <form class="form-signin" method="POST">
	        <h2 class="form-signin-heading">Log In</h2><br>
		    <div class="form-group">
			    <label for="inputEmail">E-mail Adres</label>
			    <input type="email" id="inputEmail" class="form-control" name="email" placeholder="Uw geweldige e-mail adres..." required autofocus>
		    </div>
		    <div class="form-group">
			    <label for="loginInputPassword">Wachtwoord</label>
			    <input type="password" id="loginInputPassword" class="form-control" name="password" placeholder="Uw super geheim wachtwoord..." required>
		    </div>
		    <a href="Register.php">Geen account? Hier registreren!</a>
		    <br>
	        <br>
		    <button class="btn btn-lg btn-primary btn-block" type="submit">Log in</button>
	    </form>
    </div>
</main>

<?php 
    include "inc/footer.php";
?>
