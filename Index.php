<?php
	// Load classes
	include_once "inc/Autoload.php";
	$headerTitle = "WideWorldImporters";
	$currentPage = "home";
	include "inc/Header.php";

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
				<!-- Carousel -->
				<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img class="d-block w-100" src="https://place-hold.it/1000x250/" height="250" alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="https://place-hold.it/1000x250/" height="250" alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="https://place-hold.it/1000x250/" height="250" alt="Third slide">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row bg-white border br-10 py-3 mt-3">
			<div class="col-lg-12">
				<h3>Flash Deals</h3>
				<ul class="list-inline">
					<?php foreach ($productListDeals as $product) { ?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<?php
											$image = json_decode($product["Photo"]);

											if ($image != []) {
												foreach ($image as $key => $value) {
													if ($key == 0) { ?>
														<img src="<?php echo $value ?>" class="img-fluid img-thumbnail custom-image" width="200" height="200">
													<?php }
												}
											} else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail custom-image" width="200" height="200">
										<?php } ?>
									</a>
								</div>
								<div class="">
									<span class="">EUR €<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div>

		<div class="row bg-white border br-10 py-3 mt-3">
			<div class="col-lg-12">
				<h3>Producten Onder €30</h3>
				<ul class="list-inline">
					<?php foreach ($productListUnder as $product) { ?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<?php
											$image = json_decode($product["Photo"]);

											if ($image != []) {
												foreach ($image as $key => $value) {
													if ($key == 0) { ?>
														<img src="<?php echo $value ?>" class="img-fluid img-thumbnail custom-image" width="200" height="200">
														<?php
													}
												}
											} else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail custom-image" width="200" height="200">
										<?php } ?>
									</a>
								</div>
								<div class="">
									<span class="">EUR €<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div>

		<div class="row bg-white border br-10 py-3 my-3">
			<div class="col-lg-12">
				<h3>More To Love</h3>
				<ul class="list-inline">
					<?php foreach ($productList as $product) { ?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<?php
											$image = json_decode($product["Photo"]);

											if ($image != []) {
												foreach ($image as $key => $value) {
													if ($key == 0) { ?>
														<img src="<?php echo $value ?>" class="img-fluid img-thumbnail custom-image" width="200" height="200">
														<?php
													}
												}
											} else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail custom-image" width="200" height="200">
										<?php } ?>
									</a>
								</div>
								<div class="">
									<span class="">EUR €<?php echo $product["RecommendedRetailPrice"] ?></span>
								</div>
							</div>
						</li>
					<?php } ?>
				</ul>
			</div>
		</div>
	</section>
</main>

<?php include "inc/Footer.php" ?>
