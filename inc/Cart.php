<?php
	session_start();

	$cartItems = $_SESSION["cart"];
	foreach ($cartItems as $cartItem) {
		if ($cartItem != $cartItems["misc"]) {
?>
			<li class="list-group-item border-0 px-0">
				<img src="<?php echo $cartItem["product_image"] ?>" alt="item1" class="img-thumbnail" width="70" height="70">
				<span class="shopping-cart-name"><?php echo $cartItem["product_name"] ?></span>
				<span class="shopping-cart-price">€<?php echo $cartItem["product_price"] ?></span>
				<span class="shopping-cart-quantity">Kwantiteit: <?php echo $cartItem["product_quantity"] ?></span>
				<div class="dropdown-divider mb-0"></div>
			</li>
<?php
		}
	}
?>

<?php if ($_SESSION["cart"]["misc"]["total_quantity"] != 0 && $_SESSION["cart"]["misc"]["total_price"] != 0) { ?>
	<a href="PaymentProcess.php" class="btn btn-primary btn-primary-custom d-block mt-2">Afrekenen</a>
<?php } ?>
