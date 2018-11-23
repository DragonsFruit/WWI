<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'product_list';

	// Specify header title
    $headerTitle =  "Products";

    // Category
    if(filter_has_var(INPUT_GET, "categoryId")) {
        $categoryId = filter_input(INPUT_GET, "categoryId",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $categoryId = 0;
    }

    // Pagination
    if (filter_has_var(INPUT_GET,"page")){
        $page = filter_input(INPUT_GET,"page",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $page = 1;
	}
	
	if (filter_has_var(INPUT_GET,"recordsPerPage")){
        $recordsPerPage = filter_input(INPUT_GET,"recordsPerPage",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $recordsPerPage = 15;
    }

    
    $recordsFrom = ($recordsPerPage * $page) - $recordsPerPage;

    // Count products for pagination
    $productList = new Productlist();
	$productList->getProductListBy($categoryId, 0, 5000);
	$productsList = $productList->data;
    $numberProducts = count($productsList);

    // Products from the database
    $productList = new Productlist();
	$productList->getProductListBy($categoryId, $recordsFrom, $recordsPerPage);
	$productsList = $productList->data;

    // Categories uit database
    $category = new Category();
	$category->getCategories();
    $categories = $category->data;

	include "inc/header.php";
?>
<main>
	<div class="container">
	    <div class="row">
	        <div class="col-lg-3 col-sm-12">
	            <div class="card bg-light mb-3">
	                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
	                <div class="list-group">
	                    <a href="Product_list.php" class="list-group-item list-group-item-action">All Categories</a>
	                    <?php foreach ($categories as $category) { ?>
	                        <a href="Product_list.php?categoryId=<?php echo $category["StockGroupID"];if($recordsPerPage != 0){print "&recordsPerPage=".$recordsPerPage;} ?>" class="list-group-item list-group-item-action"><?php echo $category["StockGroupName"]; ?></a>
	                    <?php }?>
	                </div>
	            </div>
	        </div>
	        <div class="col-lg-9 col-sm-12">
	            <div class="row">
		            <div class="card-deck">
	                <?php foreach ($productsList as $product) {?>
	                        <div class="card card-product card-product-list mb-3" style="min-width: 250px">
	                            <img class="card-img-top" src="https://place-hold.it/250x250/">
	                            <div class="card-body">
	                                <a class="product-name" href="product.php?id=<?php echo $product["StockItemID"] ?>">
		                                <h4 id="productName" class="card-title card-product-title"><?php echo $product["StockItemName"] ?></h4>
	                                </a>
		                            <input type="number" class="quantity-input" value="1" hidden>
									<input type="number" class="id-input" value="<?php echo $product["StockItemID"] ?>" hidden>
		                            <?php if($product["MarketingComments"] != "") { ?>
	                                    <p class="card-text card-product-text"><?php echo $product["MarketingComments"] ?></p>
		                            <?php } ?>
	                                <div class="row">
		                                <div class="col-12">
			                                <a href="#!" id="buyNowButton" class="buy-now btn btn-success btn-success-custom w-100 mb-2">
				                                <span class="price-symbol">US $</span><span id="totalPrice"><?php echo $product["RecommendedRetailPrice"] ?></span>
			                                </a>
			                                <a href="#!" id="addCartButton" class="add-to-cart btn btn-primary btn-primary-custom w-100">Add to Cart</a>
		                                </div>
	                                </div>
	                            </div>
	                        </div>
	                <?php }?>
		            </div>
	                <div class="col-12">
	                    <nav aria-label="product_pages">
	                        <ul class="pagination">
	                            <li class="page-item <?php if ($page == 1){echo "disabled";} ?>">
	                                <a class="page-link" href="Product_list.php?page=<?php if($page > 1){echo $page-1;} if($categoryId != 0){print "&categoryId=".$categoryId;}if($recordsPerPage != 0){print "&recordsPerPage=".$recordsPerPage;}?>">Previous</a>
	                            </li>
	                            <?php for($i = 1; $i <= ($numberProducts / $recordsPerPage) + 1; $i++){?>
	                                <li class="page-item <?php if($i == $page){echo "active";} ?>"><a class="page-link" href="Product_list.php?page=<?php echo $i; if($categoryId != 0){print "&categoryId=".$categoryId;}if($recordsPerPage != 0){print "&recordsPerPage=".$recordsPerPage;}?>"><?php echo $i?></a></li>
	                            <?php }?>
	                            <li class="page-item <?php if($page >= $numberProducts / $recordsPerPage){echo "disabled";} ?>">
	                                <a class="page-link" href="Product_list.php?page=<?php echo $page + 1; if($categoryId != 0){print "?categoryId=".$categoryId;}if($recordsPerPage != 0){print "&recordsPerPage=".$recordsPerPage;}?>">Next</a>
								</li>
								<!-- Werkt nog niet helemaal, categoryId wordt niet goed meegegeven -->
								<form name="numberProductsPage" method="GET" action="Product_list.php?<?php if($categoryId != 0){print "&categoryId=".$categoryId;}?>">
								<div class="form-group">
									<select name="recordsPerPage" class="form-control dropdownProducts" id="sel1">
										<option class="dropdown-item">Number per page</option>
										<option class="dropdown-item <?php if($recordsPerPage == 15){echo "active";} ?>" value=15>15</option>
										<option class="dropdown-item <?php if($recordsPerPage == 20){echo "active";} ?>" value=20>20</option>
										<option class="dropdown-item <?php if($recordsPerPage == 25){echo "active";} ?>" value=25>25</option>
										<option class="dropdown-item <?php if($recordsPerPage == 30){echo "active";} ?>" value=30>30</option>
									</select>
								</div> 
								</form>
	                        </ul>
	                    </nav>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</main>

<?php include "inc/footer.php" ?>
