<?php
    // Load classes
    include_once "inc/autoload.php";

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

	include "inc/header.php";
?>

<!-- Main -->
    <main class="detail">
        <section class="container detail-container mb-2">
            <div class="row">
                <!-- Carousel -->
                <div id="carousel-thumb" class="carousel slide carousel-fade carousel-thumbnails col-lg-6 px-0" data-ride="carousel">
                    <div class="row mx-0">
                        <div class="col-lg-2">
                            <ol class="image-thumb-list px-0">
	                            <?php
                                    $image = [0 => 'https://place-hold.it/600x500/', 1 => 'https://place-hold.it/300x600/', 2 => 'https://place-hold.it/1920x1080/', 3 => 'https://place-hold.it/400x300/'];
                                    foreach ($image as $key => $value) {
                                        if($key == 1) {
                                            echo "<li data-target='#carousel-thumb' data-slide-to='$key' class='active'><span class='img-thumb-item'>";
                                        } else {
                                            echo "<li data-target='#carousel-thumb' data-slide-to='$key'><span class='img-thumb-item'>";
                                        }

                                        echo "<img class='d-block w-100 h-100 img-fluid' src='$value'></span></li>";
                                    }
                                ?>
                            </ol>
                        </div>

                        <div class="col-lg-10 px-0">
                            <!--Slides-->
                            <div class="carousel-inner" role="listbox">
	                            <?php
		                            foreach ($image as $key => $value) {
			                            if($key == 1) {
				                            echo "<div class='carousel-item active'>";
			                            } else {
				                            echo "<div class='carousel-item'>";
			                            }

			                            echo "<img class='d-block wx-500 hx-500 img-cover' src='$value'></div>";
		                            }
	                            ?>
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
                    <h1 id="productName" class="product-name"><?php echo $product->productName; ?></h1>

                    <!-- Rating -->
                    <div class="product-rating">
                        <span class="product-star">&#9733; &#9733; &#9733; &#9733; &#9734;</span>
                        <span class="percent-num">4.0</span>
                        <span class="ratings-num">(389 votes)</span>
                    </div>

                    <!-- Price -->
                    <div class="product-price">
                        <div class="detail-description">
                            <span class="detail-title">Price:</span>
                            <div class="price-content">
                                <span class="price-symbol">US $</span><span id="productPrice" class="price"><?php echo $product->productPrice ?> </span><span class="price-unit"> / piece</span>
                            </div>
                        </div>
                        <div class="detail-description">
                            <span class="detail-title">Tax rate:</span>
                            <div class="tax-content">
                                <span class="tax-rate"><?php echo floor($product->productTaxRate) ?></span><span class="tax-unit">%</span>
                            </div>
                        </div>
                    </div>

                    <!-- Attribute -->
                    <div class="product-attribute">
                        <div class="product-info">
                            <dl class="property-item">
                               <dt class="item-title">Color:</dt>
                                <dd class="item-description">
                                    <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                        <label class="btn btn-secondary"><input type="radio" name="color" id="option1" class="btn btn-primary" autocomplete="off">Green</label>
                                        <label class="btn btn-secondary"><input type="radio" name="color" id="option2" class="btn btn-primary" autocomplete="off">Gray</label>
                                    </div>
                                </dd>
                            </dl>
                        </div>
                        <div class="product-operate-wrap">
                            <dl class="property-item">
                                <dt class="item-title">Shipping:</dt>
                                <dd class="item-description">
                                    <div class="shipment-info">
                                        <span class="shipment-cost">Free Shipping</span> to Netherlands via <span class="shipping-company">WideWorldImporters Standard Shipping</span>
                                    </div>
                                    <div class="shipment-addition-info">
                                        <p>Estimated Delivery Time: <span class="shipping-days"><?php echo $product->productLeadTimeDays ?> days</span>
                                            <button type="button" class="btn btn-circle btn-sm btn-success" data-toggle="tooltip" data-placement="bottom" title="If you finish the payment today, your order will arrive within the estimated delivery time.">?</button>
                                        </p>
                                    </div>
                                </dd>
                            </dl>

                            <!-- Quantity -->
                            <dl class="property-item">
                                <dt class="item-title">Quantity:</dt>
                                <dd class="item-description">
                                    <div class="quantity-info">
                                        <span class="quantity-modified">
                                            <input type="number" id="totalQuantity" class="quantity-input" min="1" value="1" maxlength="5" autocomplete="off">
                                        </span>
                                        <span class="unit">piece</span>
                                        <span class="available-stock">(In stock)</span>
                                    </div>
                                </dd>
                            </dl>

                        <!-- Total price -->
                            <dl class="property-item">
                                <dt class="item-title">Total price:</dt>
                                <dd class="item-description">
                                    <div class="total-price-info">
                                        <span class="total-price-show">
                                            <span class="price-symbol">US $</span><span id="totalPrice" class="total-price-value"><?php echo $product->productPrice ?></span>
                                        </span>
                                    </div>
                                </dd>
                            </dl>
                        </div>
                    </div>
	                <div class="product-actions mb-0">
		                <dl class="property-item">
			                <div class="row" id="productActionBlock">
								<span class="col-6">
									<a href="#!" id="buyNowButton" class="btn btn-success btn-success-custom w-100">Buy Now</a>
								</span>
	                            <span class="col-6">
                                    <a href="#!" id="addCartButton" class="add-to-cart btn btn-primary btn-primary-custom w-100">Add to Cart</a>
                                </span>
			                </div>
		                </dl>
	                </div>
                </div>
            </div>
        </section>
        <section class="container mb-2">
            <div class="row">
                <div class="col-lg-2 pl-0">
                    <div class="store-info-wrap" id="j-store-info-wrap" data-spm="100005" data-widget-cid="widget-37">
                        <span class="top-rated-mark"><a href="#!"></a></span>
                        <dl class="store-intro">
                            <dt>Sold By</dt>
                            <dd class="store-name mx-0">
                                <a class="store-link" href="#!">A Datum Corporation</a>
                            </dd>
                            <dd class="store-address mx-0">China</dd>
                        </dl>
                    </div>
                </div>
                <div class="col-lg-10 main-container">
                    <nav>
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                            <a class="nav-item nav-link active" id="product-details-tab" data-toggle="tab" href="#nav-product-details" role="tab" aria-controls="nav-product-details" aria-selected="true">Product Details</a>
                            <a class="nav-item nav-link" id="product-feedback-tab" data-toggle="tab" href="#nav-product-feedback" role="tab" aria-controls="nav-product-feedback" aria-selected="false">Feedback (389 votes)</a>
                            <a class="nav-item nav-link" id="product-shipping-tab" data-toggle="tab" href="#nav-product-shipping" role="tab" aria-controls="nav-product-shipping" aria-selected="false">Shipping & Payment</a>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <!-- Product details -->
                        <div class="tab-pane fade show active" id="nav-product-details" role="tabpanel" aria-labelledby="product-details-tab">
                            <div class="product-desc d-grid">
                                <!-- Product specifics -->
                                <div class="box product-property-main my-2">
                                    <div class="box-title">Product specifics</div>
                                    <div class="box-body">
                                        <ul class="product-property-list">
                                            <li class="property-item">
                                                <span class="propery-title">Brand Name:</span>
                                                <span class="propery-des"><?php // echo $productBrand ?>A Datum Corporation</span>
                                            </li>
                                            <?php
                                                $productTags = json_decode($product->productTags);
                                                foreach ($productTags as $key => $value) { ?>
                                                <li class="property-item">
                                                    <span class="propery-title">Usage <?php echo $key+1 ?>:</span>
                                                    <span class="propery-des"><?php echo $value ?></span>
                                                </li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                </div>

                                <!-- Product description -->
                                <div class="box product-property-main my-2">
                                    <div class="box-title">Product Description</div>
                                    <div class="box-body">
                                        <p class="mt-2 mb-0"><?php echo $product->productDescription ?></p>
                                    </div>
                                </div>

                                <!-- Packaging details -->
                                <div class="box product-property-main my-2">
                                    <div class="box-title">Packaging Details</div>
                                    <div class="box-body">
                                        <ul class="product-packaging-list">
                                            <li class="packaging-item">
                                                <span class="packaging-title">Unit Type:</span>
                                                <span class="packaging-des">piece</span>
                                            </li>
                                            <li class="packaging-item">
                                                <span class="packaging-title">Package Weight:</span>
                                                <span class="packaging-des"><?php echo $product->productWeight ?> kg</span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Product feedback -->
                        <div class="tab-pane fade" id="nav-product-feedback" role="tabpanel" aria-labelledby="product-feedback-tab">...</div>

                        <!-- Product shipping -->
                        <div class="tab-pane fade" id="nav-product-shipping" role="tabpanel" aria-labelledby="product-shipping-tab">...</div>
                    </div>
                </div>
            </div>
        </section>
    </main>

<?php 
    include "inc/footer.php";
?>



