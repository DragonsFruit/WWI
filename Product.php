<?php
    // Load classes
    include_once "inc/Autoload.php";

	// Set current page active
	$currentPage = 'product';

	// Get product
    $product = new Product();
	$id = filter_input(INPUT_GET, "id", FILTER_SANITIZE_NUMBER_INT);
	if (!is_null($id) && is_numeric($id)) {
	    $product->getProductDetailsWithId($id);
	} else {
		header('Location: product.php?id=1');
		die();
	}

	// Specify header title
	$headerTitle =  $product->productName;

	include "inc/Header.php";
?>

<!-- Main -->
    <main class="detail">
        <section class="container detail-container border br-10 mb-2">
            <div class="row">
                <!-- Carousel -->
                <div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails col-lg-6 px-0" data-ride="carousel">
                    <div class="row mx-0">
                        <div class="col-lg-2">
                            <ol class="image-thumb-list px-0">
	                            <?php
                                    // $image = [0 => 'https://place-hold.it/600x500/', 1 => 'https://place-hold.it/300x600/', 2 => 'https://place-hold.it/1920x1080/', 3 => 'https://place-hold.it/400x300/'];
                                    $image = json_decode($product->productPhoto);
                                    if ($image != []) {
	                                    foreach ($image as $key => $value) {
		                                    if ($key == 1) { ?>
			                                    <li data-target="#carousel-thumb" data-slide-to="<?php echo $key ?>" class="active"><span class="img-thumb-item">
	                                        <?php } else { ?>
			                                    <li data-target="#carousel-thumb" data-slide-to="<?php echo $key ?>"><span class="img-thumb-item">
	                                        <?php } ?>
	                                                <img class="d-block w-100 h-100 img-fluid img-thumbnail" src="<?php echo $value?>"></span></li>
	                                    <?php }
                                    } else { ?>
	                                    <li data-target="#carousel-thumb" data-slide-to="0" class="active">
		                                    <span class="img-thumb-item">
	                                            <img class="d-block w-100 h-100 img-fluid img-thumbnail" src="pictures/missing_product.jpg">
		                                    </span>
	                                    </li>
                                <?php } ?>
                            </ol>
                        </div>

                        <div class="col-lg-10 px-0">
                            <!--Slides-->
                            <div class="carousel-inner" role="listbox">
	                            <?php
	                                if ($image != []) {
			                            foreach ($image as $key => $value) {
				                            if($key == 1) { ?>
					                            <div class="carousel-item active">
		                                    <?php } else { ?>
					                            <div class="carousel-item">
				                            <?php } ?>
					                                <img id="productImage<?php echo $key?>" class="d-block wx-500 hx-500 img-cover img-thumbnail" src="<?php echo $value ?>">
					                            </div>
			                            <?php }
		                            } else { ?>
			                            <div class="carousel-item active">
                                            <img id="productImage0" class="d-block w-100 h-100 img-cover img-thumbnail" src="pictures/missing_product.jpg">
			                            </div>
                                <?php } ?>
                            </div>

                            <!--Controls-->
                            <a class="carousel-control-prev" href="#carousel-thumb" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carousel-thumb" role="button" data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Product details -->
                <div class="detail-wrap col-lg-6 px-0">
                    <h1 id="productName" class="product-name"><?php echo $product->productName ?></h1>

                    <!-- Rating -->
                    <div class="product-rating">
                        <span class="product-star">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
                        <span class="percent-num">4.0</span>
                        <span class="ratings-num">(389 reviews)</span>
                    </div>

                    <!-- Price -->
                    <div class="product-price">
                        <div class="detail-description">
                            <span class="detail-title">Prijs:</span>
                            <div class="price-content">
                                <span class="price-symbol">EUR €</span><span id="productPrice" class="price"><?php echo $product->productPrice ?> </span><span class="price-unit"> / stuk</span>
                            </div>
                        </div>
                        <div class="detail-description">
                            <span class="detail-title">BTW:</span>
                            <div class="tax-content">
                                <span class="tax-rate"><?php echo floor($product->productTaxRate) ?></span><span class="tax-unit">%</span>
                            </div>
                        </div>
                    </div>

                    <!-- Attribute -->
                    <div class="product-attribute">
                        <div class="product-operate-wrap">
                            <dl class="property-item">
                                <dt class="item-title">Verzenden:</dt>
                                <dd class="item-description">
                                    <div class="shipment-info">
                                        <span class="shipment-cost">Gratis verzending</span> naar Netherlands via <span class="shipping-company">WideWorldImporters Standaard Verzending</span>
                                    </div>
                                    <div class="shipment-addition-info">
                                        <p>Geschatte Leveringstijd: <span class="shipping-days"><?php echo $product->productLeadTimeDays ?> dagen</span>
                                            <button type="button" class="btn btn-circle btn-sm btn-success" data-toggle="tooltip" data-placement="bottom" title="Als u vandaag de betaling hebt voltooid, komt uw bestelling binnen de geschatte levertijd.">?</button>
                                        </p>
                                    </div>
                                </dd>
                            </dl>

                            <!-- Quantity -->
                            <dl class="property-item">
                                <dt class="item-title">Kwantiteit:</dt>
                                <dd class="item-description">
                                    <div class="quantity-info">
                                        <span class="quantity-modified">
                                            <input type="number" id="totalQuantity" class="quantity-input" min="1" value="1" maxlength="5" autocomplete="off">
                                        </span>
                                        <span class="unit">stuk</span>
                                        <span class="available-stock">(Op voorraad)</span>
                                    </div>
                                </dd>
                            </dl>

                        <!-- Total price -->
                            <dl class="property-item">
                                <dt class="item-title">Totaal prijs:</dt>
                                <dd class="item-description">
                                    <div class="total-price-info">
                                        <span class="total-price-show">
                                            <span class="price-symbol">EUR €</span><span id="totalPrice" class="total-price-value"><?php echo $product->productPrice ?></span>
                                        </span>
                                    </div>
                                </dd>
                            </dl>
                        </div>
                    </div>
	                <div class="product-actions mb-0 px-3">
		                <dl>
			                <div class="row" id="productActionBlock">
								<span class="col-6">
									<a href="#!" id="buyNowButton" class="btn btn-success btn-success-custom w-100">Nu Kopen</a>
								</span>
	                            <span class="col-6">
                                    <a href="#!" id="addCartButton" class="add-to-cart btn btn-primary btn-primary-custom w-100">In Winkelwagen</a>
                                </span>
			                </div>
		                </dl>
	                </div>
                </div>
            </div>
        </section>
        <section class="container mb-3">
            <div class="row">
                <div class="col-lg-2 pl-0">
                    <div class="store-info-wrap border br-10 py-3" data-spm="100005" data-widget-cid="widget-37">
                        <span class="top-rated-mark"><a href="#!"></a></span>
                        <dl class="store-intro">
                            <dt>Verkocht Door</dt>
                            <dd class="store-name mx-0">
                                <a class="store-link" href="#!">A Datum Corporation</a>
                            </dd>
                            <dd class="store-address mx-0">China</dd>
                        </dl>
                    </div>
                </div>
                <div class="col-lg-10 main-container border br-10 py-3">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="product-details-tab" data-toggle="tab" href="#nav-product-details" role="tab" aria-controls="nav-product-details" aria-selected="true">Productinformatie</a>
	                        <?php if ($product->youTubeID != "") { ?>
	                            <a class="nav-item nav-link" id="product-video-tab" data-toggle="tab" href="#nav-product-video" role="tab" aria-controls="nav-product-video" aria-selected="false">Video</a>
	                        <?php } ?>
	                        <a class="nav-item nav-link" id="product-feedback-tab" data-toggle="tab" href="#nav-product-feedback" role="tab" aria-controls="nav-product-feedback" aria-selected="false">Feedback (389 reviews)</a>
                            <a class="nav-item nav-link" id="product-shipping-tab" data-toggle="tab" href="#nav-product-shipping" role="tab" aria-controls="nav-product-shipping" aria-selected="false">Verzending & Betaling</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <!-- Product details -->
                        <div class="tab-pane fade show active" id="nav-product-details" role="tabpanel" aria-labelledby="product-details-tab">
                            <div class="product-desc d-grid">
                                <!-- Product specifics -->
                                <div class="box product-property-main my-2">
                                    <div class="box-title">Product specificaties</div>
                                    <div class="box-body">
                                        <ul class="product-property-list">
                                            <li class="property-item">
                                                <span class="propery-title">Merknaam:</span>
                                                <span class="propery-des"><?php // echo $productBrand ?>A Datum Corporation</span>
                                            </li>
                                            <?php
                                                $productTags = json_decode($product->productTags);
                                                foreach ($productTags as $key => $value) { ?>
                                                <li class="property-item">
                                                    <span class="propery-title">Gebruik <?php echo $key+1 ?>:</span>
                                                    <span class="propery-des"><?php echo $value ?></span>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Product description -->
                                <div class="box product-property-main my-2">
                                    <div class="box-title">Product Beschrijving</div>
                                    <div class="box-body">
                                        <p class="mt-2 mb-0"><?php echo $product->productDescription ?></p>
                                    </div>
                                </div>
                            </div>
                        </div>

	                    <?php if ($product->youTubeID != "") {?>
		                    <!-- Product video -->
		                    <div class="tab-pane fade" id="nav-product-video" role="tabpanel" aria-labelledby="product-video-tab">
			                    <div class="mt-3">
			                        <iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/<?php echo $product->youTubeID ?>" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
			                    </div>
		                    </div>
	                    <?php } ?>

                        <!-- Product feedback -->
                        <div class="tab-pane fade" id="nav-product-feedback" role="tabpanel" aria-labelledby="product-feedback-tab"></div>

                        <!-- Product shipping -->
                        <div class="tab-pane fade" id="nav-product-shipping" role="tabpanel" aria-labelledby="product-shipping-tab">
	                        <p class="text-warning mt-3">Gratis verzending naar Netherlands via WideWorldImporters Standaard Verzending</p>
	                        <!-- Packaging details -->
	                        <div class="box product-property-main my-2">
		                        <div class="box-title">Verpakkingsdetails</div>
		                        <div class="box-body">
			                        <ul class="product-packaging-list">
				                        <li class="packaging-item">
					                        <span class="packaging-title">Eenheidstype:</span>
					                        <span class="packaging-des">stuk</span>
				                        </li>
				                        <li class="packaging-item">
					                        <span class="packaging-title">Pakket Gewicht:</span>
					                        <span class="packaging-des"><?php echo $product->productWeight ?> kg</span>
				                        </li>
			                        </ul>
		                        </div>
	                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

<?php 
    include "inc/Footer.php";
?>



