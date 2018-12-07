<?php
	// Load classes
	include_once "inc/Autoload.php";

	// Set current page active
	$currentPage = 'payment_process';
	$headerTitle =  "Payment";

	include "inc/Header.php";
	$totalPrice = $_SESSION["cart"]["misc"]["total_price"];
?>

<main>
	<div class="container bg-white border br-10 py-3">
	    <div class="row">
	        <div class="col-12">
				<ul class="nav nav-tabs tab-nav-main" id="myTab" role="tablist">
					<?php if(!isset($_SESSION['user'])) { ?>
					<li class="nav-item">
						<a class="nav-link active" id="bevestig-tab" data-toggle="tab" href="#nav-bevestig" role="tab" aria-controls="nav-bevestig" aria-selected="true">Bevestig bestelling</a>
					</li>
					<?php } ?>
					<li class="nav-item">
						<a class="nav-link <?php if(isset($_SESSION['user'])) { echo "active"; } ?>" id="product-betaling-tab" data-toggle="tab" href="#nav-product-betaling" role="tab" aria-controls="nav-product-feedback" aria-selected="false">Betaling</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="product-klaar-tab" data-toggle="tab" href="#nav-product-klaar" role="tab" aria-controls="nav-product-shipping" aria-selected="false">Klaar</a>
					</li>
				</ul>
	            <div class="tab-content" id="nav-tabContent">
		            <?php if(!isset($_SESSION['user'])) { ?>
	                <!-- Product confirmation -->
	                <div class="tab-pane fade show active" id="nav-bevestig" role="tabpanel" aria-labelledby="bevestig-tab">
	                    <div class="row">
							<form class="mt-3 container" action="javascript:confirmPurchase()">
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputEmail4">E-mail adres</label>
										<input type="email" class="form-control" id="inputEmail" placeholder="Voer hier uw e-mail adres in..." required>
									</div>
									<div class="form-group col-md-6">
										<label for="inputPassword4">Wachtwoord</label>
										<input type="password" class="form-control" id="inputPassword" placeholder="Voer hier uw wachtwoord in..." required>
									</div>
								</div>
								<div class="form-group">
									<label for="inputAddress">Adres</label>
									<input type="text" class="form-control" id="inputAddress" placeholder="Anemoonstraat 20" required>
								</div>
								<div class="form-row">
									<div class="form-group col-md-6">
										<label for="inputCity">Stad</label>
										<input type="text" class="form-control" id="inputCity" placeholder="Amsterdam" required>
									</div>
									<div class="form-group col-md-2">
										<label for="inputZip">Postcode</label>
										<input type="text" class="form-control" id="inputZip" placeholder="1234 AB" required>
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
								<button class="btn btn-primary text-white" type="submit">Next</button>
							</form>
						</div>
	                </div>
		            <?php } ?>
					<!-- Payment -->
	                <div class="tab-pane fade show <?php if(isset($_SESSION['user'])) { echo "active"; } ?>" id="nav-product-betaling" role="tabpanel" aria-labelledby="product-betaling-tab">
		                <div class="row">
			                <div class="container credit-card-container br-10">
				                <div class="mGrid">
					                <div class="total">
						                <p>Totaalbedrag</p>
						                <p>€<?php echo $totalPrice?></p>
					                </div>
					                <div class="detail my-3">
						                <p>Detail</p>
						                <ul class="pl-0">
							                <?php
								                $cartItems = $_SESSION["cart"];

								                foreach ($cartItems as $cartItem) {
									                if ($cartItem != $cartItems["misc"]) {
							                            ?>
										                <li><?php echo $cartItem["product_name"] ?></li>
										                <li>€<?php printf("%.2f", $cartItem['product_price']) ?></li>
										                <li><?php echo $cartItem['product_quantity'] ?>x</li>
							                <?php
									                }
								                }
							                ?>
						                </ul>
					                </div>
					                <a class="btn btn-primary btn-primary-custom btn-next px-5 align-self-center">Bevestig Betaling</a>
					                <div id="error-message" role="alert"></div>
				                </div>
				                <div class="sub-container br-10 my-auto mx-auto">
					                <div class="card-bank-name br-10">
						                <select class="custom-select" id="ideal-bank" required>
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
					                </div>
					                <div class="card-holder br-10 align-middle">
						                <input type="text" placeholder="Uw naam" required>
					                </div>
					                <div class="card-account-number br-10"></div>
					                <div class="card-number br-10"></div>
					                <div class="card-date br-10"></div>
					                <div class="card-ccv br-10"></div>
				                </div>
			                </div>
			                <input id="userId" value="<?php echo (isset($_SESSION["user"]["user_id"])) ? $_SESSION["user"]["user_id"] : 1 ?>" hidden>
			                <input id="totalItems" value="<?php echo $_SESSION["cart"]["misc"]["total_quantity"] ?>" hidden>
						</div>
	                </div>
		            <!-- Finished -->
	                <div class="tab-pane fade show" id="nav-product-klaar" role="tabpanel" aria-labelledby="product-klaar-tab">
		                <div class="row">
			                <div class="mx-auto mt-3 text-center">
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
    include "inc/Footer.php";
?>
