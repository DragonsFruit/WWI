<?php
    session_start();
    include "class/Product.php";
    var_dump($_SESSION['cart']);
    foreach ($_SESSION['cart'] as $key => $value) {
        print($value);
    }
?>