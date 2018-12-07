<?php
	if (session_status() == PHP_SESSION_NONE) {
		session_start();
	}

	if ($currentPage == "login" && isset($_SESSION["user"]) || $currentPage == "invoice" && !isset($_SESSION["user"])) {
		header("Location: Index.php");
		die();
	} elseif ($currentPage == "payment_process" && isset($_SESSION["cart"]) && $_SESSION["cart"]["misc"]["total_price"] == 0) {
		header("Location: Index.php");
		die();
	}

	if(!isset($_SESSION["cart"]) && !isset($_SESSION["user"])){
		$cartSession = [
			"cart" => [
				"misc" => [
					"total_price" => 0,
					"total_quantity" => 0,
				]
			],
		];
		$_SESSION = $cartSession;
	} elseif (!isset($_SESSION["cart"]) && isset($_SESSION["user"])) {
		$cartSession = [
			"misc" => [
				"total_price" => 0,
				"total_quantity" => 0,
			]
			,
		];
		$_SESSION["cart"] = $cartSession;
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
	<script src="js/datatables.min.js"></script>
	<script src="js/responsive.bootstrap4.min.js"></script>
	<script src="js/main.js"></script>

	<title><?php echo (!$headerTitle) ? 'WideWorldImporters' : $headerTitle ?> | WWI</title>
</head>

<body>
    <!--Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light">
		<div class="container px-0">
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
            <a class="navbar-brand mx-0" href="index.php">
                <img src="pictures/WideWorldImportersLogo.png" width="40" height="40" class="d-inline-block align-top" alt="WideWorldImporters"><span class="align-middle d-none d-sm-inline-block"><span style="color: #00aeef;">Wide World</span> Importers</span>
            </a>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
                <form class="form-inline my-2 my-lg-0 mx-auto">
                    <div class="input-group search-main w-100">
                        <input id="search" class="form-control search" type="search" placeholder="Ik ben opzoek naar..." aria-label="Search" autocomplete="off" spellcheck="false">
	                    <div id="searchResultsBox" class="w-100 position-absolute d-none"></div>
                        <div class="input-group-append">
                            <select id="category" class="browser-default custom-select" name="category">
	                            <option value="0" selected>Alle Categorieën</option>
	                            <?php foreach ($categories as $category) { ?>
		                            <option value="<?php echo $category["StockGroupID"] ?>"><?php echo $category["StockGroupName"] ?></option>
	                            <?php } ?>
	                            <option value="0">Alle Categorieën</option>
                            </select>
                            <button class="btn btn-primary btn-search" type="submit"><i class="fa fa-search text-grey" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </form>

				<ul class="navbar-nav position-relative">
					<?php if (!isset($_SESSION['user']['username'])) { ?>
						<li class="nav-item position-relative">
							<a href="Login.php" class="nav-link pt-4 plx-30">
								<i class="far fa-user nav-icon"></i>
								<span class="pl-1">Login</span>
							</a>
						</li>
					<?php } else { ?>
						<li class="nav-item position-relative dropdown">
							<a href="#!" class="nav-link pt-4 plx-30 dropdown-toggle" data-toggle="dropdown">
								<i class="far fa-user nav-icon"></i>
								<span class="pl-1"><?php echo "Hallo, " . $_SESSION['user']['username'] ?></span>
							</a>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="Invoices.php">Bestellingen overzicht</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item text-danger bg-transparent" id="logOut" href="#!">Loguit</a>
							</div>
						</li>
					<?php } ?>
					<li class="nav-item position-relative <?php if($currentPage =='product'){echo 'active';}?>">
						<a href="ProductList.php" class="nav-link pt-4 plx-30">
							<i class="far fa-th-large nav-icon"></i>
							<span class="pl-1">Producten</span>
						</a>
					</li>
					<li class="nav-item position-relative dropdown <?php if($currentPage =='cart'){echo 'active';}?>">
						<a href="#!" id="shoppingCartButton" class="nav-link pt-4 plx-30 dropdown-toggle cart" data-toggle="dropdown">
							<i class="far fa-shopping-cart nav-icon"></i>
							<span class="mw-100 of-hidden pl-1">Winkelwagen</span>
						</a>
						<span class="cart-counter mt-1 px-2"><?php echo (!$_SESSION["cart"]["misc"]["total_quantity"]) ? 0 : $_SESSION["cart"]["misc"]["total_quantity"] ?></span>
						<div class="dropdown-menu shopping-cart">
							<div class="shopping-cart-main">
								<div class="shopping-cart-header">
									<div class="shopping-cart-total">
										<span class="lighter-text">Totaal:</span>
										<span class="main-color-text">€<span id="shoppingCartTotalPrice"><?php echo (!$_SESSION["cart"]["misc"]["total_price"]) ? 0 : $_SESSION["cart"]["misc"]["total_price"] ?></span></span>
										<span class="lighter-text" style="float: right"><a href="ShoppingCart.php">Naar winkelwagen</a></span>
									</div>
								</div>
								<div class="dropdown-divider"></div>
								<ul id="shoppingCartBox" class="shopping-cart-items list-group"></ul>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<hr class="W-100 my-0">
