<?php
	include_once "inc/Autoload.php";
	session_start();

	$currentPage = "shopping_cart";
	$headerTitle =  "Shopping Cart";

	if (filter_input(INPUT_GET, 'action') == 'delete') {
		foreach($_SESSION['cart'] as $key => $product) {
			if ($key == filter_input(INPUT_GET, 'id')) {
				unset($_SESSION['cart'][$key]);
				// Totals
				$oldTotalQuantity = $_SESSION["cart"]["misc"]["total_quantity"];
				// $totalQuantity = $oldTotalQuantity + $newQuantity;
				$totalQuantity = array_sum(array_column($_SESSION['cart'], 'product_quantity'));

				$oldTotalPrice = $_SESSION["cart"]["misc"]["total_price"];
				// $totalPrice = $oldTotalPrice + $newPrice;
				$totalPrice = array_sum(array_column($_SESSION['cart'], 'product_price'));

				$misc = [
					"total_quantity" => $totalQuantity,
					"total_price" => $totalPrice
				];
				$_SESSION["cart"]["misc"] = $misc;
			}
		}
	}

	$totalQuantity = $_SESSION["cart"]["misc"]["total_quantity"];

	include "inc/Header.php";
?>

<main>
	<div class="container bg-white py-3 border br-10">
		<h1>Uw Bestellingen</h1>
		<table id="cart" class="table table-hover table-condensed">
			<?php if ($_SESSION["cart"]["misc"]["total_quantity"] != 0 && $_SESSION["cart"]["misc"]["total_price"] != 0) { ?>
				<thead>
				<tr>
					<th style="width:2%">Bestelling</th>
					<th style="width:58%">Beschrijving</th>
					<th style="width:8%">Aantal</th>
					<th style="width:22%" class="text-center">Totaal</th>
					<th style="width:10%"></th>
				</tr>
				</thead>
				<tbody>
				<?php
					$cartItems = $_SESSION["cart"];

					foreach ($cartItems as $cartItem) {
						if ($cartItem != $cartItems["misc"]) {
							?>
							<tr id="listItem">
								<td data-th="Product">
									<div class="row">
										<div class="col-sm-3 hidden-xs">
											<?php if ($cartItem['product_image'] != "") { ?>
												<img src="<?php echo $cartItem['product_image'] ?>" alt="<?php echo $cartItem['product_name'] ?>" id="productImage" class="img-responsive img-thumbnail" width="100" height="100" />
											<?php } else {?>
												<img src="pictures/missing_product.jpg" alt="<?php echo $cartItem['product_name'] ?>" id="productImage" class="img-responsive img-thumbnail" width="100" height="100" />
											<?php }?>
										</div>
										<div class="col-sm-9">
											<h4 class="mx-0" id="productName"><?php echo $cartItem['product_name'] ?></h4>
										</div>
									</div>
								</td>
								<td data-th="Price">€<span id="productPrice"><?php echo round($cartItem['product_price'], 2, PHP_ROUND_HALF_UP) / $cartItem['product_quantity'] ?></span></td>
								<td data-th="Quantity">
									<input type="number" id="quantityInput" class="form-control product-quantity text-center" value="<?php echo $cartItem['product_quantity'] ?>" min="1">
									<input type="number" id="productId" value="<?php echo $cartItem['product_id'] ?>" hidden>
								</td>
								<td data-th="Subtotal" class="text-center">€<span id="subtotalPrice"><?php echo $cartItem['product_price'] ?></span></td>
								<td class="actions" data-th="">
									<a href="ShoppingCart.php?action=delete&id=<?php echo $cartItem['product_id'] ?>" class="btn btn-danger btn-danger-custom">
										<i class="far fa-trash-alt"></i> Verwijder
									</a>
								</td>
							</tr>
							<?php
						}
					}
				?>
				</tbody>
			<?php } else { ?>
				<tbody>
					<tr id="listItem">
						<td data-th="Product">
							<span class="text-center d-block my-5">
								<i class="far fa-receipt" style="font-size: 128px;"></i>
								<h3>Dit is uw bestelling overzicht.</h3>
								<p>Wanneer u klaar bent met het betalingsprocedure worden uw bestellingen hier getoond!</p>
							</span>
						</td>
					</tr>
				</tbody>
			<?php } ?>
			<tfoot>
			<tr>
				<td><a href="ProductList.php" class="btn btn-secondary btn-secondary-custom"><i class="fa fa-angle-left"></i> Verder winkelen</a></td>
				<td colspan="2" class="hidden-xs"></td>
			</tr>
			</tfoot>
		</table>
	</div>
</main>

<?php
	include "inc/Footer.php";
?>
