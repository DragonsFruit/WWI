<?php
	// Load classes
	include_once "inc/autoload.php";

	// Set current page active
	$currentPage = 'product_list';

	// Specify header title
    $headerTitle =  "Products";


    //tijdelijk 0
    
    if(filter_has_var(INPUT_GET, "categoryId")) {
        $categoryId = filter_input(INPUT_GET, "categoryId",FILTER_SANITIZE_NUMBER_INT);
    } else {
        $categoryId = 0;
    }
    
    $productlist = new Productlist();
	$productlist->getProductlistBy($categoryId);
    $productlists = $productlist->data;

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
                        <div class="card">
                            <img class="card-img-top" src="https://dummyimage.com/600x400/55595c/fff" alt="Card image cap">
                            <div class="card-body">
                                <h4 class="card-title"><a href="product.php?id=<?php echo $product["StockItemID"]; ?>" title="View Product"><?php echo $product["StockItemName"]; ?></a></h4>
                                <p class="card-text"><?php echo $product["MarketingComments"]; ?></p>
                                <div class="row">
                                    <div class="col">
                                        <p class="btn btn-warning btn-block"><?php echo $product["RecommendedRetailPrice"]; ?></p>
                                    </div>
                                    <div class="col">
                                        <a href="#" class="btn btn-primary btn-block">Add to cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php }?>
                <div class="col-12">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Previous</a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">1</a></li>
                            <li class="page-item active">
                                <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

    </div>
</div>
<?php include "inc/footer.php" ?>