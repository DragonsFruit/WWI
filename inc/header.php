<?php
	session_start();

	if ($currentPage == "login" && isset($_SESSION["user"])) {
		header("Location: index.php");
		die();
	}

	if(!isset($_SESSION["cart"])){
		$product = [
			"cart" => [
				"misc" => [
					"total_price" => 0,
					"total_quantity" => 0,
				]
			],
		];
		$_SESSION = $product;
	}

	$category = new Category();
	$category->getCategories();
	$categories = $category->data;
?>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="ie=edge">

	<!-- Stylesheets -->
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/fontawesome.min.css">
	<link rel="stylesheet" href="css/bootstrap.min.css">

	<!-- JS -->
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>

	<title><?php echo (!$headerTitle) ? 'WideWorldImporters' : $headerTitle; ?> | WWI</title>
</head>

<body>
    <!--Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
            <a class="navbar-brand mx-0" href="index.php">
                <img src="pictures/WideWorldImportersLogo.png" width="40" height="40" class="d-inline-block align-top" alt="WideWorldImporters"><span class="align-middle d-none d-sm-inline-block"><span style="color: #00aeef;">Wide World</span> Importers</span>
            </a>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
                <form class="form-inline my-2 my-lg-0 mx-auto">
                    <div class="input-group search-main w-100">
                        <input id="search" class="form-control search" type="search" placeholder="I'm shopping for..." aria-label="Search" autocomplete="off" spellcheck="false">
	                    <div id="searchResultsBox" class="w-100 position-absolute d-none"></div>
                        <div class="input-group-append">
                            <select id="category" class="browser-default custom-select" name="category">
	                            <option value="0" selected>All Categories</option>
	                            <?php foreach ($categories as $category) { ?>
		                            <option value="<?php echo $category["StockGroupID"];?>"><?php echo $category["StockGroupName"];?></option>
	                            <?php } ?>
	                            <option value="0">All Categories</option>
                            </select>
                            <button class="btn btn-primary btn-search" type="submit"><i class="fa fa-search text-grey" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </form>

				<ul class="navbar-nav">
					<?php if (!isset($_SESSION['user']['username'])) { ?>
						<li class="nav-item">
							<a href="login.php" class="nav-link"><i class="far fa-user"></i> Login</a>
						</li>
					<?php } else { ?>
						<li class="nav-item">
							<a href="index.php" class="nav-link"><i class="far fa-user"></i> <?php echo "Hello, " . $_SESSION['user']['username'] ?></a>
						</li>
					<?php } ?>
					<li class="nav-item <?php if($currentPage =='product'){echo 'active';}?>">
						<a href="product_list.php" class="nav-link"><i class="far fa-th-large"></i> Products</a>
					</li>
					<li class="nav-item <?php if($currentPage =='cart'){echo 'active';}?>">
						<span class="cart-counter mt-1 px-2"><?php echo (!$_SESSION["cart"]["misc"]["total_quantity"]) ? 0 : $_SESSION["cart"]["misc"]["total_quantity"] ?></span>
						<a href="#cart" id="shoppingCartButton" class="nav-link cart position-relative">
							<i class="far fa-shopping-cart"></i>
							<span>Cart</span>
						</a>
						<div id="shoppingCart" class="position-absolute d-none">
							<div class="shopping-cart">
								<div class="shopping-cart-header">
									<div class="shopping-cart-total">
										<span class="lighter-text">Total:</span>
										<span class="main-color-text">$<span id="shoppingCartTotalPrice"><?php echo (!$_SESSION["cart"]["misc"]["total_price"]) ? 0 : $_SESSION["cart"]["misc"]["total_price"] ?></span></span>
										<span class="lighter-text" style="float: right"><a href="shopping_cart.php">Go to cart</a></span>
									</div>
								</div>

								<ul id="shoppingCartBox" class="shopping-cart-items list-group list-group-flush"></ul>

								<a href="paymentprocess.php" class="btn btn-primary btn-primary-custom d-block mt-2">Checkout</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<hr class="W-100 my-0">
