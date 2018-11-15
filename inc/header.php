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
            <a class="navbar-brand mx-0" href="#">
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
<!--					<li class="nav-item --><?php //if($currentPage =='home'){echo 'active';}?><!--">-->
<!--						<a href="#hoofdpagina" class="nav-link">Home</a>-->
<!--					</li>-->
					<li class="nav-item <?php if($currentPage =='product'){echo 'active';}?>">
						<a href="product_list.php" class="nav-link"><i class="far fa-th-large"></i> Products</a>
					</li>
<!--					<li class="nav-item --><?php //if($currentPage =='customerService'){echo 'active';}?><!--">-->
<!--						<a href="#klantenservice" class="nav-link">Customer Service</a>-->
<!--					</li>-->
					<li class="nav-item <?php if($currentPage =='cart'){echo 'active';}?>">
						<span class="cart-counter mt-1 px-2">0</span>
						<a href="#winkelmandje" class="nav-link cart position-relative">
							<i class="far fa-shopping-cart"></i>
							<span>Cart</span>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
