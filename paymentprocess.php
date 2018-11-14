<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'home';

	$headerTitle =  "wideworldimporters";

	include "inc/header.php";
?>

<main class="container">
    <div class="row">
        <div class="col-12">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="bevestig-tab" data-toggle="tab" href="#nav-bevestig" role="tab" aria-controls="nav-bevestig" aria-selected="true">Bevestig bestelling</a>
                    <a class="nav-item nav-link" id="product-betaling-tab" data-toggle="tab" href="#nav-product-betaling" role="tab" aria-controls="nav-product-feedback" aria-selected="false">Betaling</a>
                    <a class="nav-item nav-link" id="product-klaar-tab" data-toggle="tab" href="#nav-product-klaar" role="tab" aria-controls="nav-product-shipping" aria-selected="false">Klaar</a>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <!-- Product bevestiging -->
                <div class="tab-pane fade show active" id="nav-bevestig" role="tabpanel" aria-labelledby="bevestig-tab">
                	<div class="container">
						<form class="mt-3">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Email</label>
									<input type="email" class="form-control" id="inputEmail4" placeholder="Email">
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Password</label>
									<input type="password" class="form-control" id="inputPassword4" placeholder="Password">
								</div>
							</div>
							<div class="form-group">
								<label for="inputAddress">Address</label>
								<input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
							</div>
							<div class="form-group">
								<label for="inputAddress2">Address 2</label>
								<input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
							</div>
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputCity">City</label>
									<input type="text" class="form-control" id="inputCity">
								</div>
								<div class="form-group col-md-4">
									<label for="inputState">State</label>
									<select id="inputState" class="form-control">
										<option selected>Choose...</option>
										<option>...</option>
									</select>
								</div>
								<div class="form-group col-md-2">
									<label for="inputZip">Zip</label>
									<input type="text" class="form-control" id="inputZip">
								</div>
							</div>
							<div class="form-group">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="gridCheck">
									<label class="form-check-label" for="gridCheck">
									Check me out
									</label>
								</div>
							</div>
							<button type="submit" class="btn btn-primary">Sign in</button>
						</form>
					</div>
                </div>
                <div class="tab-pane fade show active" id="nav-product-betaling" role="tabpanel" aria-labelledby="product-betaling-tab">
                </div>
                <div class="tab-pane fade show active" id="nav-product-klaar" role="tabpanel" aria-labelledby="product-klaar-tab">
                </div>
            </div>
        </div>
    </div>
</main>