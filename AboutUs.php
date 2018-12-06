<?php
	// Load classes
	include_once "inc/Autoload.php";

	// Set current page active
	$currentPage = 'About_us';
	$headerTitle =  "About_us";

	include "inc/Header.php";
	$totalPrice = $_SESSION["cart"]["misc"]["total_price"];
?>
<main>
    <div class="container">
        <nav aria-label="breadcrumb"> 
            <ol class="breadcrumb bg-white text-white">
                <li class="breadcrumb-item"><a href="http://localhost/wwi/index.php">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">About us</li>
            </ol>
        </nav>

    <div class="card border border-secondary">
                <div class="card-body">
                    <h5 class="card-title">Over ons</h5>
                    <h6 class="card-subtitle mb-2 text-muted"></h6>
                    <p class="card-text">Wij zijn WWI. We zijn trots op onze producten en geloven in kwaliteit. In ieder huis vindt een
                                          product van WWI zijn thuis. Ondanks onze grootte zien klanten ons als kleinschalig en
                                          betrokken. Persoonlijk klantcontact staat bij ons hoog in het vaandel.</p>
                    <br>
                    <p></p>
                </div>
            </div>
        </div>
</main>

<?php
    include "inc/Footer.php";
?>
