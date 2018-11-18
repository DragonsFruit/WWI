<?php
	session_start();

	$cartItems = $_SESSION["cart"];
	foreach ($cartItems as $cartItem) {
		if ($cartItem != $cartItems["misc"]) {
?>
			<li class="list-group-item">
				<img src="https://place-hold.it/70x70/" alt="item1" />
				<span class="shopping-cart-name"><?php echo $cartItem["product_name"] ?></span>
				<span class="shopping-cart-price">$<?php echo $cartItem["product_price"] ?></span>
				<span class="shopping-cart-quantity">Quantity: <?php echo $cartItem["product_quantity"] ?></span>
			</li>
<?php
		}
	}
?>
