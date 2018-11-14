<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'home';

	$headerTitle =  "wideworldimporters";

	include "inc/header.php";
?>



<main>

	<section class="container">
    	<div class="row">
			<!-- Carousel -->
			<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
  				<div class="carousel-inner">
    				<div class="carousel-item active">
      					<img class="d-block w-100" src="https://place-hold.it/600x500/" alt="First slide">
    				</div>
    				<div class="carousel-item">
      					<img class="d-block w-100" src="https://place-hold.it/300x600/" alt="Second slide">
    				</div>
    				<div class="carousel-item">
      					<img class="d-block w-100" src="https://place-hold.it/1920x1080/" alt="Third slide">
    				</div>
  				</div>
			</div>
		</div>
    </section>
</main>

<?php include "inc/footer.php" ?>