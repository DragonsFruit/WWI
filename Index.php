<?php
	// Load classes
	include_once "inc/autoload.php";
	$headerTitle = "WideWorldImporters";
	$currentPage = "home";
	include "inc/header.php";

	// Products in random
	$productList = new Productlist();
	$productList->getProducts();
	$productList = $productList->data;

	// Products under certain price
	$productListUnder = new Productlist();
	$productListUnder->getProductsUnder(30);
	$productListUnder = $productListUnder->data;

	// Products with deals
	$productListDeals = new Productlist();
	$productListDeals->getProductsWithDeals(50);
	$productListDeals = $productListDeals->data;

?>

<main>
	<section class="container">
    	<div class="row">
		    <div class="col-lg-12">
<!--				Carousel -->
				<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
	                <div class="carousel-inne h-25">
	                    <div class="carousel-item active">
	                        <img class="d-block w-100" src="https://place-hold.it/600x500/" height="250" alt="First slide">
	                    </div>
	                    <div class="carousel-item">
	                        <img class="d-block w-100" src="https://place-hold.it/300x600/" height="250" alt="Second slide">
	                    </div>
	                    <div class="carousel-item">
	                        <img class="d-block w-100" src="https://place-hold.it/1920x1080/" height="250" alt="Third slide">
	                    </div>
	                </div>
				</div>
		    </div>
		</div>
		<div class="row product-deals mt-3 bg-white">
			<div class="col-lg-12">
				<h3>Flash Deals</h3>
				<ul class="list-inline">
					<?php foreach ($productListDeals as $product) {?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<img src="//ae01.alicdn.com/kf/HTB1.KXlX6zuK1RjSspeq6ziHVXa4.jpg_220x220.jpg" class="img-fluid img-thumbnail" width="200">
									</a>
								</div>
								<div class="">
									<span class="">US $<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div>

		<!-- <div class="row product-deals mt-3 bg-white">
			<div class="col-lg-12">
				<h3>Products Under $30</h3>
				<ul class="list-inline">
					<?php foreach ($productListUnder as $product) {?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<img src="//ae01.alicdn.com/kf/HTB1.KXlX6zuK1RjSspeq6ziHVXa4.jpg_220x220.jpg" class="img-fluid img-thumbnail" width="200">
									</a>
								</div>
								<div class="">
									<span class="">US $<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div> -->

		<!-- <div class="row product-deals my-3 bg-white">
			<div class="col-lg-12">
				<h3>More To Love</h3>
				<ul class="list-inline">
					<?php foreach ($productList as $product) {?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<img src="//ae01.alicdn.com/kf/HTB1.KXlX6zuK1RjSspeq6ziHVXa4.jpg_220x220.jpg" class="img-fluid img-thumbnail" width="200">
									</a>
								</div>
								<div class="">
									<span class="">US $<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div> -->
    </section>
</main>

<?php include "inc/footer.php" ?>
