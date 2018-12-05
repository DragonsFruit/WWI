<?php
	session_start();

	$cartItems = $_SESSION["cart"];
	foreach ($cartItems as $cartItem) {
		if ($cartItem != $cartItems["misc"]) {
?>
			<li class="list-group-item">
				<img src="pictures/missing_product.jpg" alt="item1" width="70" height="70"/>
				<span class="shopping-cart-name"><?php echo $cartItem["product_name"] ?></span>
				<span class="shopping-cart-price">€<?php echo $cartItem["product_price"] ?></span>
				<span class="shopping-cart-quantity">Kwantiteit: <?php echo $cartItem["product_quantity"] ?></span>
			</li>
<?php
		}
	}
?>
