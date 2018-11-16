<?php
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
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

	<!-- JS -->
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
	<script src="https://js.stripe.com/v3/"></script>
	<script src="js/main.js"></script>
	

	<title><?php echo $headerTitle; ?> | WWI</title>
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
                <form class="form-inline my-2 my-lg-0 mx-auto w-70">
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
					<li class="nav-item <?php if($currentPage =='product'){echo 'active';}?>">
						<a href="product_list.php" class="nav-link"><i class="far fa-th-large"></i> Products</a>
					</li>
					<li class="nav-item <?php if($currentPage =='cart'){echo 'active';}?>">
						<span class="cart-counter mt-1 px-2">0</span>
						<a href="#cart" id="shoppingCart" class="nav-link cart position-relative">
							<i class="far fa-shopping-cart"></i>
							<span>Cart</span>
						</a>
						<div id="shoppingCartItems" class="position-absolute d-none">
							<div class="shopping-cart">
								<div class="shopping-cart-header">
									<i class="fa fa-shopping-cart cart-icon"></i><span class="badge">3</span>
									<div class="shopping-cart-total">
										<span class="lighter-text">Total:</span>
										<span class="main-color-text">$2,229.97</span>
									</div>
								</div>
								<!--end shopping-cart-header -->

								<ul class="shopping-cart-items list-group list-group-flush">
									<?php
										$cartItems = $_SESSION["cart"];
										foreach ($cartItems as $cartItem) {
									?>
									<li class="list-group-item">
										<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/195612/cart-item1.jpg" alt="item1" />
										<span class="item-name"><?php echo $cartItem["item_name"]?></span>
										<span class="item-price"><?php echo $cartItem["product_price"]?></span>
										<span class="item-quantity"><?php echo $cartItem["item_quantity"]?></span>
									</li>
									<?php }?>
								</ul>

								<a href="paymentprocess.php" class="btn btn-primary d-block mt-2">Checkout</a>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</nav>
