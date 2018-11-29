<?php
	include_once "autoload.php";

	$search = new Search();

	//Getting value of "search" variable from "script.js".
	if (isset($_POST['search'])) {
		//Search box value assigning to $Name variable.
		$name = $_POST['search'];
		$category = $_POST['category'];
		
		$search->getProductsWith($name, $category);
		$searchResults = $search->data;
		//Creating unordered list to display result.
		echo '<div class="list-group">';
		//Fetching result from database.
		foreach ($searchResults as $searchResult) {
?>
			<a id="<?php echo $searchResult["StockItemID"]?>" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center" href="product.php?id=<?php echo $searchResult["StockItemID"]?>">
				<?php
					$image = json_decode($searchResult["Photo"]);
					$itemName = $searchResult["StockItemName"];

					if (!is_null($image)) {
						foreach ($image as $key => $value) {
							if ($key == 0) {
								echo "<img src=\"$value\" class=\"search-image\" height=\"40\" width=\"40\" alt=\"$itemName\" />";
							}
						}
					} else {
						echo "<img src=\"https://placehold.it/40x40\" class=\"search-image\" height=\"40\" width=\"40\" alt=\"$itemName\" />";
					}
				?>
				<span class="search-description w-100 mx-2"><?php echo $searchResult["SearchDetails"]; ?></span>
				<span class="badge badge-primary badge-pill">$<?php echo $searchResult["RecommendedRetailPrice"]; ?></span>
			</a>
<?php
		}
	}
	echo "</div>";
?>
