<?php
    include_once "inc/autoload.php";

	$currentPage = "shopping_cart";

	$headerTitle =  "Shopping Cart";
	include "inc/header.php";
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
?>

<main>
	<div class="container">
		<h1>Your Shopping Cart <small id="shoppingCartTotalCount" style="font-size: 16px;">(<?php echo ($totalQuantity > 0) ? "$totalQuantity Items" : "$totalQuantity Item" ?>)</small></h1>
		<table id="cart" class="table table-hover table-condensed">
			<thead>
				<tr>
					<th style="width:50%">Product</th>
					<th style="width:10%">Price</th>
					<th style="width:8%">Quantity</th>
					<th style="width:22%" class="text-center">Subtotal</th>
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
										<div class="col-sm-3 hidden-xs"><img src="http://placehold.it/100x100" alt="..." class="img-responsive" /></div>
										<div class="col-sm-9">
											<h4 class="mx-0" id="productName"><?php echo $cartItem['product_name'] ?></h4>
										</div>
									</div>
								</td>
								<td data-th="Price">$<span id="productPrice"><?php echo $cartItem['product_price'] / $cartItem['product_quantity'] ?></span></td>
								<td data-th="Quantity">
									<input type="number" id="quantityInput" class="form-control text-center" value="<?php echo $cartItem['product_quantity'] ?>" min="0">
									<input type="number" id="productId" value="<?php echo $cartItem['product_id'] ?>" hidden>
								</td>
								<td data-th="Subtotal" class="text-center">$<span id="subtotalPrice"><?php echo $cartItem['product_price']?></span></td>
								<td class="actions" data-th="">
									<a href="shopping_cart.php?action=delete&id=<?php echo $cartItem['product_id'] ?>" class="btn btn-danger btn-danger-custom">
										<i class="far fa-trash-alt"></i> Remove
									</a>
								</td>
							</tr>
				<?php
						}
			        }
				?>
	        </tbody>
	        <tfoot>
		        <tr>
			        <td><a href="product_list.php" class="btn btn-secondary btn-secondary-custom"><i class="fa fa-angle-left"></i> Continue Shopping</a></td>
			        <td colspan="2" class="hidden-xs"></td>
			        <td class="hidden-xs text-center"><strong id="totalPrice">Total $<?php echo $_SESSION["cart"]["misc"]["total_price"] ?></strong></td>
			        <td><a href="paymentprocess.php" class="btn btn-success btn-success-custom">Checkout <i class="fa fa-angle-right"></i></a></td>
		        </tr>
	        </tfoot>
	    </table>
	</div>
</main>

<?php
    include "inc/footer.php";
?>
