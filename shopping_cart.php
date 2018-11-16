<?php
    session_start();
    include_once "inc/autoload.php";
    $currentPage = 'Shopping Cart';
    include "inc/header.php";
?>

<?php
    var_dump($_SESSION['cart']);
    foreach ($_SESSION['cart'] as $key => $product) {
    ?>
        <table class="table">
            <tr>
                <td> <?php echo $product['item_name']; ?> </td>
                <td> <?php echo $product['item_quantity']; ?> </td>
                <td> <?php echo $product['product_price']; ?> </td>
                <td> 
                    <a href="shopping_cart.php?action=delete&id=<?php echo $product['product_id']; ?>">
                        <div class="btn-danger">Remove</div>
                </td>
            </tr>
        </table>
    <?php
    }   


    if (filter_input(INPUT_GET, 'action') == 'delete') {
        foreach($_SESSION['cart'] as $key => $product) {
            if ($key == filter_input(INPUT_GET, 'id')) {
                unset($_SESSION['cart'][$key]);
            }
        }
    }
?>

<?php 
    include "inc/footer.php";
?>