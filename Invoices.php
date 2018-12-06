<?php
	include_once "inc/Autoload.php";

	$currentPage = "invoice";
	$headerTitle =  "Invoices";

	include "inc/Header.php";

	$userId = $_SESSION["user"]["user_id"];

	$invoice = new Invoice();
	$invoice->getInvoicesFor($userId);
	$invoices = $invoice->data;
?>

<main>
	<div class="container bg-white py-3 border br-10">
		<h1>Uw Bestellingen</h1>
		<?php if ($invoices != []) { ?>
			<table id="invoiceTable" class="table table-hover table-condensed">
				<thead>
					<tr>
						<th>Bestelling</th>
						<th>Datum</th>
						<th>Beschrijving</th>
						<th>Aantal</th>
						<th>Totaal</th>
						<th>Afgeleverd</th>
						<th>Ontvanger</th>
					</tr>
				</thead>
				<tbody>
				<?php
					foreach ($invoices as $invoice) {
						?>
						<tr id="listItem">
							<td data-th="Bestelling">
								<span>#<?php echo $invoice['CustomerPurchaseOrderNumber'] ?></span>
							</td>
							<td data-th="Datum">
								<span><?php echo $invoice['InvoiceDate'] ?></span>
							</td>
							<td data-th="Beschrijving">
								<span><?php echo $invoice["Description"]?></span>
							</td>
							<td data-th="Aantal">
								<span><?php echo $invoice['Quantity'] ?></span>
							</td>
							<td data-th="Totaal">
								<span>€<?php printf("%.2f", ($invoice['RecommendedRetailPrice'] * $invoice['Quantity'])) ?></span>
							</td>
							<td data-th="Afgeleverd">
								<span><?php echo $invoice['ConfirmedDeliveryTime'] ?></span>
							</td>
							<td data-th="Ontvangen door">
								<span><?php echo $invoice['ConfirmedReceivedBy'] ?></span>
							</td>
						</tr>
						<?php
					}
				?>
				</tbody>
			</table>
			<?php } else { ?>
			<table class="table table-hover table-condensed">
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
				<tfoot>
					<tr>
						<td><a href="ProductList.php" class="btn btn-secondary btn-secondary-custom"><i class="fa fa-angle-left"></i> Verder winkelen</a></td>
						<td colspan="2" class="hidden-xs"></td>
					</tr>
				</tfoot>
			</table>
		<?php } ?>
	</div>
</main>

<?php
	include "inc/Footer.php";
?>
