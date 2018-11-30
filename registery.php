<?php
	// Load classes
	include_once "inc/autoload.php";
	
	// Set current page active
	$currentPage = 'product';

	// Specify header title
	$headerTitle =  "form";

	include "inc/header.php";

	if (isset($_POST["voornaam"]) &&
        isset($_POST["achternaam"])) {
		$registration = new Registration();
		$email = $_POST['email'];
		$wachtwoord = $_POST['wachtwoord'];
		$voornaam = $_POST['voornaam'];
		$achternaam = $_POST['achternaam'];
		$postcode = $_POST['postcode'];
		$straat = $_POST['adres'];
		$huisnummer = $_POST['nummer'];
		$stad = $_POST['stad'];
        $registration->registerUserPassword($email, $wachtwoord, $voornaam, $achternaam, $postcode, $straat, $huisnummer, $stad);
    }
?>

<main>
<div class="container">
	<form method='POST'>
	<h2 class="form-signin-heading">Log in</h2><br>
		<div class="form-row">
			<div class="form-group col-md-4">
				<label for="inputEmail">Email</label>
				<input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email">
			</div>
			<div class="form-group col-md-4">
				<label for="inputPassword">Password</label>
				<input type="password" class="form-control" id="inputPassword" name="wachtwoord" placeholder="Password">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-4">
				<label for="inputFirstName">First Name</label>
				<input type="text" class="form-control" id="inputFirstName" name="voornaam">
			</div>
			<div class="form-group col-md-4">
				<label for="inputLastName">Last Name</label>
				<input type="text" class="form-control" id="inputLastName" name="achternaam">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="inputAddress">Address</label>
				<input type="text" class="form-control" id="inputAddress" name="adres">
			</div>
			<div class="form-group col-md-2">
				<label for="inputNumber">Number</label>
				<input type="text" class="form-control" id="inputNumber" name="nummer">
			</div>
		</div>
		<div class="form-row">
			<div class="form-group col-md-6">
				<label for="inputCity">City</label>
				<input type="text" class="form-control" id="inputCity" name="stad">
			</div>
			<div class="form-group col-md-2">
				<label for="inputZip">Zip</label>
				<input type="text" class="form-control" id="inputZip" name="postcode">
			</div>
		</div>
		<button type="submit" class="btn btn-primary">Register</button>
	</form>
</div>
</main>

<?php
	include "inc/footer.php"
?>