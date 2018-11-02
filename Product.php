<?php
    // Connectie naar database file
    include "classes/DB.php";
?>

<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- Stylesheets -->
    <link rel="stylesheet" href="css/style.css">

    <!-- JS -->

    <title><?php echo $productNaam; ?> | WWI</title>
</head>

<nav class="nav-bar">
  <a href="#hoofdpagina" class="nav-button">Hoofdpagina</a>
  <a href="#producten" class="nav-button">Producten</a>
  <a href="#klantenservice" class="nav-button">Klantenservice</a>
  <a href="#winkelmandje" class="nav-button">Winkelmandje</a>
</nav>
<body>
    <div class="productAfbeelding">
        <?php 
            echo '<img src="data:image/jpeg;base64,'.base64_encode($blob).'"/>';
        ?>
    </div>
    <div class="productInformatie">
        <?php echo $productNaam; ?>
    </div>
    <div class="bestelKnop">
        TEST
    </div>
    <div class="productBeschrijving">
        <?php echo $productBeschrijving ?>
    </div>
    <div>
</body>
</html>