<?php
	// Load classes
	include_once "inc/Autoload.php";
	
	// Set current page active
	$currentPage = 'product';

	// Specify header title
	$headerTitle =  "form";

	include "inc/Header.php";

	if (isset($_POST["voornaam"]) &&
		isset($_POST["achternaam"]) &&
		isset($_POST["wachtwoord"]))
		 {
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
	<div class="container bg-white py-3 border br-10">
		<form method='POST'>
			<h2 class="form-signin-heading">Registratie</h2>
			<br>
			<div class="form-row">
				<div class="form-group col-md-4">
					<label for="inputEmail">E-mail Adres</label>
					<input type="email" class="form-control" id="inputEmail" name="email" placeholder="Voer hier uw e-mail adres in..." required>
				</div>
				<div class="form-group col-md-4">
					<label for="inputPassword">Wachtwoord</label>
					<input type="password" class="form-control" id="inputPassword" name="wachtwoord" placeholder="Voer hier uw wachtwoord in..." required>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-4">
					<label for="inputFirstName">Voornaam</label>
					<input type="text" class="form-control" id="inputFirstName" name="voornaam" required>
				</div>
				<div class="form-group col-md-4">
					<label for="inputLastName">Achternaam en Tussennaam</label>
					<input type="text" class="form-control" id="inputLastName" name="achternaam" required>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputAddress">Adres</label>
					<input type="text" class="form-control" id="inputAddress" name="adres" required>
				</div>
				<div class="form-group col-md-2">
					<label for="inputNumber">Huisnummer</label>
					<input type="text" class="form-control" id="inputNumber" name="nummer" required>
				</div>
			</div>
			<div class="form-row">
				<div class="form-group col-md-6">
					<label for="inputCity">Stad</label>
					<input type="text" class="form-control" id="inputCity" name="stad" required>
				</div>
				<div class="form-group col-md-2">
					<label for="inputZip">Postcode</label>
					<input type="text" class="form-control" id="inputZip" name="postcode" required>
				</div>
			</div>
			<button type="submit" class="btn btn-primary">Registreren</button>
		</form>
	</div>
</main>

<?php
	include "inc/Footer.php"
?>
