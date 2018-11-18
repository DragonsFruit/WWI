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

    $recordsPerPage = 20;
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
<div class="container">
    <div class="row">
        <div class="col-12 col-sm-3">
            <div class="card bg-light mb-3">
                <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>
                <ul class="list-group category_block">
                <li class="list-group-item"><a href="Product_list.php">Alle Categories</a></li>
                    <?php foreach ($categories as $category) { ?>
                        <li class="list-group-item"><a href="Product_list.php?categoryId=<?php echo $category["StockGroupID"]; ?>"><?php echo $category["StockGroupName"]; ?></a></li>
                    <?php }?>   
                </ul>
            </div>
        </div>
        <div class="col">
            <div class="row">
                <?php foreach ($productlists as $product) {?>
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card card_margin">
                            <img class="card-img-top" style="heigth:400px width:600px" src="https://place-hold.it/600x500/" alt="Card image cap">
                            <div class="card-body">
                                <h4 class="card-title title_card"><a class="product-name title_card" href="product.php?id=<?php echo $product["StockItemID"]; ?>" title="View Product"><?php echo $product["StockItemName"]; ?></a></h4>
                                <p class="card-text text_card"><?php echo $product["MarketingComments"]; ?></p>
                                <div class="row">
                                    <div class="price_list col-12">
                                       <span class="price-symbol">US $</span><span class="total-price-value"><?php echo $product["RecommendedRetailPrice"]; ?></span>
                                    </div>
                                    <div class="col">
                                        <a href="product.php?id=<?php echo $product["StockItemID"]; ?>" class="btn btn-primary w-100">View Product</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php }?>
                <div class="col-12">
                    <nav aria-label="product_pages">
                        <ul class="pagination">
                            <li class="page-item <?php if ($page == 1){echo "disabled";} ?>">
                                <a class="page-link" href="Product_list.php?page=<?php if($page > 1){echo $page-1;} if($categoryId != 0){print "&categoryId=".$categoryId;}?>">Previous</a>
                            </li>
                            <?php for($i = 1; $i <= ($numberProducts / $recordsPerPage) + 1; $i++){?>
                                <li class="page-item <?php if($i == $page){echo "active";} ?>"><a class="page-link" href="Product_list.php?page=<?php echo $i; if($categoryId != 0){print "&categoryId=".$categoryId;}?>"><?php echo $i?></a></li>
                            <?php }?>
                            <li class="page-item <?php if($page >= $numberProducts / $recordsPerPage){echo "disabled";} ?>">
                                <a class="page-link" href="Product_list.php?page=<?php echo $page + 1; if($categoryId != 0){print "&categoryId=".$categoryId;}?>">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</main>

<?php include "inc/footer.php" ?>
