<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'contact';
	$headerTitle =  "Contact";

	include "inc/header.php";
	$totalPrice = $_SESSION["cart"]["misc"]["total_price"];
?>
    <main>
        <!-- <div class="container">
            <a href="http://localhost/wwi/index.php">Home</a> >> <span style="<?php if($currentPage == 'contact'){echo('font-weight: bold;');}?>">Contact</span>
        <div> -->

        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-white text-white">
                    <li class="breadcrumb-item"><a href="http://localhost/wwi/index.php">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Contact</li>
                </ol>
            </nav>
            <div class="card border border-secondary">
                <div class="card-body">
                    <h5 class="card-title">Contact</h5>
                    <h6 class="card-subtitle mb-2 text-muted"></h6>
                    <p class="card-text">Als je vragen of opmerkingen hebt kun je het beste contact opnemen met onze klantenservice via je account.<br> 
                    Log hiervoor in bovenaan de pagina en stuur ons een bericht via ons Klantenservice Contact Center.<br> 
                    Op deze manier kunnen wij alle gegevens en bestellingen bekijken die bij jouw account horen.<br>
                    Wij streven er altijd naar om binnen 24 uur te reageren.
                    <br><br>
                    <b>Ons adres:</b><br><br>

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