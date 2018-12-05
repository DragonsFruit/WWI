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
				<!-- Carousel -->
				<div id="carouselExampleSlidesOnly" class="carousel slide" data-ride="carousel">
					<div class="carousel-inner">
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
		<div class="row bg-white border br-10 py-3 mt-3">
			<div class="col-lg-12">
				<h3>Flash Deals</h3>
				<ul class="list-inline">
					<?php foreach ($productListDeals as $product) { ?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<?php if ($product["Photo"] != "") { ?>
											<img src="<?php echo $product["Photo"] ?>" class="img-fluid img-thumbnail" width="200">
										<?php } else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail" width="200">
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
										<?php if ($product["Photo"] != "") { ?>
											<img src="<?php echo $product["Photo"] ?>" class="img-fluid img-thumbnail" width="200">
										<?php } else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail" width="200">
										<?php } ?>
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

		<div class="row bg-white border br-10 py-3 my-3">
			<div class="col-lg-12">
				<h3>More To Love</h3>
				<ul class="list-inline">
					<?php foreach ($productList as $product) { ?>
						<li class="list-inline-item">
							<div class="">
								<div class="">
									<a href="product.php?id=<?php echo $product["StockItemID"] ?>">
										<?php if ($product["Photo"] != "") { ?>
											<img src="<?php echo $product["Photo"] ?>" class="img-fluid img-thumbnail" width="200">
										<?php } else { ?>
											<img src="pictures/missing_product.jpg" class="img-fluid img-thumbnail" width="200">
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

<?php include "inc/footer.php" ?>
