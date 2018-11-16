<?php 
    session_start();
    $pid=$_POST['id'];
    $name = $_POST['name'];
    $price = $_POST['price'];
    $quantity = $_POST['quantity'];
    $newproduct=array(
        'product_id' => $pid,
        'item_name' => $name,
        'product_price' => $price,
        'item_quantity' => $quantity
    );
    $_SESSION['cart'][$pid]= $newproduct;
?>