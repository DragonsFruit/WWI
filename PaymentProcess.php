<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'payment_process';
	$headerTitle =  "Payment";

	include "inc/header.php";
	$totalPrice = $_SESSION["cart"]["misc"]["total_price"];
?>

<main>
	<div class="container bg-white border br-10 py-3">
	    <div class="row">
	        <div class="col-12">
				<ul class="nav nav-tabs tab-nav-main" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" id="bevestig-tab" data-toggle="tab" href="#nav-bevestig" role="tab" aria-controls="nav-bevestig" aria-selected="true">Bevestig bestelling</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="product-betaling-tab" data-toggle="tab" href="#nav-product-betaling" role="tab" aria-controls="nav-product-feedback" aria-selected="false">Betaling</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="product-klaar-tab" data-toggle="tab" href="#nav-product-klaar" role="tab" aria-controls="nav-product-shipping" aria-selected="false">Klaar</a>
					</li>
				</ul>
	            <div class="tab-content" id="nav-tabContent">
	                <!-- Product confirmation -->
	                <div class="tab-pane fade show active" id="nav-bevestig" role="tabpanel" aria-labelledby="bevestig-tab">
	                    <div class="row">
							<form class="mt-5 container">
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputEmail4">Email</label>
										<input type="email" class="form-control" id="inputEmail4" placeholder="Email" required>
									</div>
									<div class="form-group col-md-6">
										<label for="inputPassword4">Password</label>
										<input type="password" class="form-control" id="inputPassword4" placeholder="Password" required>
									</div>
								</div>
								<div class="form-group">
									<label for="inputAddress">Address</label>
									<input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St" required>
								</div>
								<div class="form-group">
									<label for="inputAddress2">Address 2</label>
									<input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputCity">City</label>
										<input type="text" class="form-control" id="inputCity" required>
									</div>
									<div class="form-group col-md-4">
										<label for="inputState">State</label>
										<select id="inputState" class="form-control" required>
											<option selected >Choose...</option>
											<option>...</option>
										</select>
									</div>
									<div class="form-group col-md-2">
										<label for="inputZip" >Zip</label>
										<input type="text" class="form-control" id="inputZip" required>
									</div>
								</div>
								<div class="form-group">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="newsletter">
										<label class="form-check-label" for="newsletter">Ja, ik wil graag op de hoogte gehouden worden van bijzondere aanbiedingen en kortingen.</label>
										<br>
										<input class="form-check-input" type="checkbox" id="termsOfServices" required>
										<label class="form-check-label" for="termsOfServices">Ik ga akkoord met de algemene voorwaarden.</label>
									</div>
								</div>
								<a class="btn btn-primary btn-next text-white">Next</a>
							</form>
						</div>
	                </div>
					<!-- Payment -->
	                <div class="tab-pane fade show" id="nav-product-betaling" role="tabpanel" aria-labelledby="product-betaling-tab">
						<div class="row">
			                <div id="payment-form" class="mt-5 container">
								<div><p>Totaalbedrag: $<?php echo $totalPrice?></p></div>

								<label for="ideal-bank">iDEAL Bank: </label>
								<select class="custom-select" id="ideal-bank">
									<option selected>Kies uw bank</option>
									<option value="abn_amro">ABN AMRO</option>
									<option value="asn_bank">ASN Bank</option>
									<option value="bunq">Bunq</option>
									<option value="ing">ING</option>
									<option value="knab">Knab</option>
									<option value="moneyou">Moneyou</option>
									<option value="rabobank">Rabobank</option>
									<option value="regiobank">RegioBank</option>
									<option value="sns_bank">SNS Bank (De Volksbank)</option>
									<option value="triodos_bank">Triodos Bank</option>
									<option value="van_lanschot">Van Lanschot</option>
								</select>
								<br>
								<br>
								<a class="btn btn-primary btn-next text-white">Submit Payment</a>

								<!-- Used to display form errors. -->
								<div id="error-message" role="alert"></div>
			                </div>
						</div>
	                </div>
		            <!-- Finished -->
	                <div class="tab-pane fade show" id="nav-product-klaar" role="tabpanel" aria-labelledby="product-klaar-tab">
		                <div class="row">
			                <div class="mx-auto mt-5 text-center">
				                <div class="circle-loader mx-auto mb-3">
					                <div class="checkmark draw"></div>
				                </div>
				                <span class="payment-description"></span>
			                </div>
		                </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</main>


<?php 
    include "inc/footer.php";
?>
