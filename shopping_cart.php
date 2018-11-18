<?php
    include_once "inc/autoload.php";

	$headerTitle =  "Shopping Cart";

    include "inc/header.php";

	if (filter_input(INPUT_GET, 'action') == 'delete') {
		foreach($_SESSION['cart'] as $key => $product) {
			if ($key == filter_input(INPUT_GET, 'id')) {
				unset($_SESSION['cart'][$key]);
			}
		}
	}

    $totalQuantity = $_SESSION["cart"]["misc"]["total_quantity"];
?>

<main>
	<div class="container">
		<h1>Your Shopping Cart <small style="font-size: 16px;">(<?php echo ($totalQuantity > 0) ? "$totalQuantity Items" : "$totalQuantity Item" ?>)</small></h1>
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
							<tr>
								<td data-th="Product">
									<div class="row">
										<div class="col-sm-3 hidden-xs"><img src="http://placehold.it/100x100" alt="..." class="img-responsive" /></div>
										<div class="col-sm-9">
											<h4 class="mx-0"><?php echo $cartItem['product_name'] ?></h4>
										</div>
									</div>
								</td>
								<td data-th="Price">$<?php echo $cartItem['product_price'] / $cartItem['product_quantity'] ?></td>
								<td data-th="Quantity">
									<input type="number" class="form-control text-center" value="<?php echo $cartItem['product_quantity'] ?>">
								</td>
								<td data-th="Subtotal" class="text-center">$<?php echo $cartItem['product_price']?></td>
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
			        <td class="hidden-xs text-center"><strong>Total $<?php echo $_SESSION["cart"]["misc"]["total_price"] ?></strong></td>
			        <td><a href="paymentprocess.php" class="btn btn-success btn-success-custom">Checkout <i class="fa fa-angle-right"></i></a></td>
		        </tr>
	        </tfoot>
	    </table>
	</div>
</main>

<?php
    include "inc/footer.php";
?>
