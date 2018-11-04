<?php
	$currentPage = 'product';

    // Connectie naar database file
    include "classes/DB.php";
    include "partials/Header.php";
?>



<!-- Main -->
    <main class="detail">
        <section class="container detail-container">
            <div class="row">
                <!-- Product images-->
                <div class="col-lg-5 px-0">
                    <div id="carouselIndicators" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#carouselIndicators" data-slide-to="0" class="active"></li>
                            <li data-target="#carouselIndicators" data-slide-to="1"></li>
                        </ol>
                        <div class="carousel-inner">
                            <?php
                                $image = [1,2];
                                foreach ($image as $key => $value) {
                                    if($key == 1) {
                                        echo "<div class='carousel-item active'>";
                                    } else {
                                        echo "<div class='carousel-item'>";
                                    }

                                    echo "<img class='d-block w-100' src='https://via.placeholder.com/500x500'/></div>";
                                }
                            ?>
                        </div>
                        <a class="carousel-control-prev" href="#carouselIndicators" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselIndicators" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>

                <!-- Product details -->
                <div class="detail-wrap col-lg-7 px-0">
                    <h1 class="product-name"><?php echo $productNaam; ?></h1>

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
                                <span class="price-symbol">EUR €</span><span class="price"><?php echo $productPrijs ?></span><span class="price-unit">/ piece</span>
                            </div>
                        </div>
                        <div class="detail-description">
                            <span class="detail-title">Tax rate:</span>
                            <div class="tax-content">
                                <span class="tax-rate"><?php echo floor($productBtw) ?></span><span class="tax-unit">%</span>
                            </div>
                        </div>
                    </div>

                    <!-- Attribute -->
                    <div class="product-attribute">
                        <form action="cart.php">
                            <div class="product-info">
                                <dl class="property-item">
                                   <dt class="item-title">Color:</dt>
                                    <dd class="item-description">
                                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                            <label class="btn btn-secondary"><input type="radio" name="color" id="option1" class="btn btn-primary" autocomplete="off">1</label>
                                            <label class="btn btn-secondary"><input type="radio" name="color" id="option2" class="btn btn-primary" autocomplete="off">2</label>
                                            <label class="btn btn-secondary"><input type="radio" name="color" id="option3" class="btn btn-primary" autocomplete="off">3</label>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                            <div class="product-operate-wrap">
                                <dl class="property-item">
                                    <dt class="item-title">Shipping:</dt>
                                    <dd class="item-description">
                                        <div class="shipment-info">
                                            <span class="shipment-cost">Free Shipping</span> to Netherlands via <span class="shipping-company">WorldWideImporters Standard Shipping</span>
                                        </div>
                                        <div class="shipment-addition-info">
                                            <p>Estimated Delivery Time: <span class="shipping-days"><?php echo $productBezorgTijd ?> days</span>
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
                                                <input type="number" class="quantity-input" min="1" value="1" maxlength="5" autocomplete="off">
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
                                                <span class="price-symbol">EUR €</span><span class="total-price-value">14.5</span>
                                            </span>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </section>
    </main>

<?php include "partials/Footer.php" ?>

