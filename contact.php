<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'payment_process';
	$headerTitle =  "Payment";

	include "inc/header.php";
	$totalPrice = $_SESSION["cart"]["misc"]["total_price"];
?>
    <main>
        <div class="container">
            <div class="card border border-secondary">
                <div class="card-body">
                    <h5 class="card-title">Contact</h5>
                    <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                    <p class="card-text">Als je vragen of opmerkingen hebt kun je het beste contact opnemen met onze klantenservice via je account.<br> 
                    Log hiervoor in bovenaan de pagina en stuur ons een bericht via ons Klantenservice Contact Center.<br> 
                    Op deze manier kunnen wij alle gegevens en bestellingen bekijken die bij jouw account horen.<br>
                    Wij streven er altijd naar om binnen 24 uur te reageren.
                    <br><br>
                    Ons adres:<br><br>

                    adres<br><br>

                    Je kunt je vragen altijd naar dit adres sturen, maar houdt er rekening mee dat producten niet naar dit adres kunnen worden teruggestuurd.<br>
                    Als je een product wilt terugsturen, neem dan contact op met onze klantenservice via je account. Zij kunnen je hierbij verder helpen.<br></p>
                </div>
            </div>
        </div>
    </main









<?php
    include "inc/footer.php";
?>