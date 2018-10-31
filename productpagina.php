<?php
    $productAfbeelding = "TEST";
    $productInformatie = "TEST";
    $productBeschrijving = "TEST";
?>
<html>
<link rel="stylesheet" href="style.css"> 
<nav class="nav-bar">
  <a href="#hoofdpagina" class="nav-button">Hoofdpagina</a>
  <a href="#producten" class="nav-button">Producten</a>
  <a href="#klantenservice" class="nav-button">Klantenservice</a>
  <a href="#winkelmandje" class="nav-button">Winkelmandje</a>
</nav>
<body>
    <div class="productAfbeelding">
        <?php echo $productAfbeelding ?>
    </div>
    <div class="productInformatie">
        <?php echo $productInformatie ?>
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