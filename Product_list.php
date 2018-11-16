<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'product_list';

	// Specify header title
    $headerTitle =  "Products";


    //category
    if(filter_has_var(INPUT_GET, "categoryId")) {
        $categoryId = filter_input(INPUT_GET, "categoryId",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $categoryId = 0;
    }

    //pagination (lang niet af, limiet is nu 20 per pagina)
    if (filter_has_var(INPUT_GET,"page")){
        $page = filter_input(INPUT_GET,"page",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $page = 1;
    }

    $recordsPerPage = 20;
    $recordsFrom = ($recordsPerPage * $page) - $recordsPerPage;

    //count products (voor pagination)
    $productlist = new Productlist();
	$productlist->getProductlistBy($categoryId, 0, 5000);
    $productlists = $productlist->data;
    $numberProducts = count($productlists);

    //products uit database
    $productlist = new Productlist();
	$productlist->getProductlistBy($categoryId, $recordsFrom, $recordsPerPage);
    $productlists = $productlist->data;

    //categories uit database
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
                <li class="list-group-item"><a href="Product_list.php">All Categories</a></li>
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
                            <img class="card-img-top" src="https://dummyimage.com/600x400/55595c/fff" alt="Card image cap">
                            <div class="card-body">
                                <h4 class="card-title title_card"><a href="product.php?id=<?php echo $product["StockItemID"]; ?>" title="View Product"><?php echo $product["StockItemName"]; ?></a></h4>
                                <p class="card-text text_card"><?php echo $product["MarketingComments"]; ?></p>
                                <div class="row">
                                    <div class="col-12">
                                        <a href="#!" id="buyNowButton" class="buy_now_list btn btn-warning w-100"><span class="price-symbol">US $</span><?php echo $product["RecommendedRetailPrice"]; ?></a>
                                    </div>
                                    <div class="col">
                                        <a href="#!" id="addCartButton" class="add-to-cart btn btn-primary w-100">Add to Cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php }?>
                <div class="col-12">
                    <nav aria-label="product_pages">
                        <ul class="pagination">
                            <li class="page-item">
                                <a class="page-link" href="Product_list.php?page=<?php if($page > 1){$page -= 1;} echo $page; if($categoryId != 0){print "&categoryId=".$categoryId;}?>" tabindex="-1">Previous</a>
                            </li>
                            <?php for($i = 1; $i <= ($numberProducts / $recordsPerPage) + 1; $i++){?>
                            <li class="page-item <?php if($i == $page + 1 ){echo "active";} ?>"><a class="page-link" href="Product_list.php?page=<?php echo $i; if($categoryId != 0){print "&categoryId=".$categoryId;}?>"><?php echo $i?></a></li>
                            <?php }?>
                            <!-- tijdelijk uitgeschakeld <li class="page-item active">
                                <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li> -->
                            <li class="page-item <?php if($page >= ($numberProducts / $recordsPerPage) - 1){echo "disabled";} ?>">
                                <a class="page-link" href="Product_list.php?page=<?php $page += 2; echo $page; if($categoryId != 0){print "&categoryId=".$categoryId;}?>">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    </div>
</div>
<?php include "inc/footer.php" ?>