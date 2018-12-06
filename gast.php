<?php
	// Load classes
	include_once "inc/Autoload.php";
	
	// Set current page active
	$currentPage = 'product';

	// Specify header title
	$headerTitle =  "form";

	include "inc/Header.php";
?>

<div class="container">
<form>
<div class="form-group">

<div class="form-group">
    <div class="form-group col-md-4">
      <label for="inputEmail4">Email</label>
      <input type="email" class="form-control" id="inputEmail4" placeholder="Email">
    </div>
    
<div class="form-group col-md-4">
      <label for="inputnaam4">Naam</label>
      <input type="Naam" class="form-control" id="inputnaam4" placeholder="Naam">
    </div>

    <div class="form-group col-md-4">
      <label for="inputachternaam">Achternaam</label>
      <input type="Naam" class="form-control" id="inputachternaam4" placeholder="Achternaam">
    </div>
  
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">Land</label>
      <select id="inputState" class="form-control">
        <option selected>Kies...</option>
        <option>...</option>
      </select>
    </div>

          <div class="form-group col-md-4">
      <label for="inputachternaam">Postcode</label>
      <input type="Postcode" class="form-control" id="inputpostcode4" placeholder="Postcode">
    </div>
    
    <div class="form-group col-md-4">
      <label for="inputCity">huisnummer + toevoeging </label>
      <input type="text" class="form-control" id="inputCity">
    </div>

        <div class="form-group col-md-4">
      <label for="inputCity">Straatnaam </label>
      <input type="text" class="form-control" id="straatnaam">
    </div>

        <div class="form-group col-md-4">
      <label for="inputCity">plaats </label>
      <input type="text" class="form-control" id="plaats">
    </div>

    <div class="form-group col-md-4">
      <label for="inputCity">Telefoon </label>
      <input type="text" class="form-control" id="Telefoon">
    </div>
</form>
</div>

<div class="container">
<form>
<div class="form-group">
    <div class="form-check">
      <input class="form-check-input" type="checkbox" id="gridCheck">
      <label class="form-check-label" for="gridCheck">
      Ik ga akkoord met de algemene voorwaarden
      </label>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">Bestel</button>
</form>
</div>
