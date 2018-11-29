// Find get parameter
function findGetParameter(parameterName) {
    let result = null,
        tmp = [];
    location.search.substr(1).split("&").forEach(function (item) {
          tmp = item.split("=");
          if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        });
    return result;
}

// Check required inputs
function checkRequiredInputs() {
	let isValid = true;
	$("input").filter("[required]").each(function() {
		if ($(this).prop("type") == "checkbox") {
			if ($(this).prop("checked") === false) {
				isValid = false;
				$(this).addClass("error");
				return false;
			}
		}

		if ($(this).val() === "") {
			isValid = false;
			$(this).addClass("error");
			return false;
		}
		
		$(this).removeClass("error");
	});
	return isValid;
}

// Search for product
function searchProduct() {
	let searchValue = $("#search").val().trim();
	let categoryValue = $("#category").val().trim();

	let searchResultBox = $("#searchResultsBox");
	searchResultBox.removeClass("d-none");

	if (!searchValue.trim()) {
		searchResultBox.addClass("d-none");
		searchResultBox.html("");
	} else {
		$.ajax({
			type: "POST",
			url: "inc/search.php",
			data: {
				search: searchValue,
				category: categoryValue
			},
			success: function (html) {
				searchResultBox.html(html).show();
			}
		});
	}
}

// Get shopping cart products
function getShoppingCartProducts() {
	let shoppingCartBox = $("#shoppingCartBox");
	shoppingCartBox.removeClass("d-none");

	$.ajax({
		type: "POST",
		url: "inc/cart.php",
		success: function (html) {
			shoppingCartBox.html(html).show();
		}
	});
}

$(document).ready(function () {
	// Enable tooltip
	$('[data-toggle="tooltip"]').tooltip();

	// Calculate product total price
	$(".quantity-input").change("change", function () {
		let totalCost = $("#productPrice").html() * $(this).val();
		$("#totalPrice").html(Math.round(totalCost * 100) / 100);
	});

	// Search when typing or category is changed
	$("#search").keyup(function () {
		searchProduct();
	});

	$("#search").focusin(function () {
		let searchResultBox = $("#searchResultsBox");
		searchResultBox.removeClass("d-none");
	});

	// $("#search").focusout(function () {
	// 	let searchResultBox = $("#searchResultsBox");
	// 	searchResultBox.addClass("d-none");
	// });

	$("#category").change(function () {
		searchProduct();
	});

    $("#category").focusin(function () {
	    let searchResultBox = $("#searchResultsBox");
	    searchResultBox.removeClass("d-none");
    });

    $("#category").focusout(function () {
	    let searchResultBox = $("#searchResultsBox");
	    searchResultBox.addClass("d-none");
    });

    // Add to cart
	$("a.add-to-cart").click(function(event) {
		let id = findGetParameter("id");
		let productName = $("#productName").html().trim();

		let quantityInput = $(".quantity-input").val();
		let cartCounter = $(".cart-counter").html().trim();
		let count = Number(cartCounter) + Number(quantityInput);

		let oldTotalPrice = $("#shoppingCartTotalPrice").html().trim();
		let newTotalPrice = $("#totalPrice").html().trim();
		let totalPrice = Number(oldTotalPrice) + Number(newTotalPrice);

		if (id === null) {
			id = $(this).parents(".card-product").find(".id-input").val();
			productName = $(this).parents(".card-product").find("#productName").html().trim();

			quantityInput = $(this).parents(".card-product").find(".quantity-input").val();

			newTotalPrice = $(this).parents(".card-product").find("#totalPrice").html().trim();
		}

		$.ajax({
			type: "POST",
			url: "inc/add-to-cart.php",
			data: {
				id: id,
				name: productName,
				quantity: quantityInput,
				price: newTotalPrice,
			}
		});

		let button = $(this);
		button.addClass("size");
		setTimeout(function() {
			button.addClass("hover");
		}, 200);
		setTimeout(function() {
			$(".cart-counter").text(count);
			$("#shoppingCartTotalPrice").text(totalPrice);
		}, 600);
		setTimeout(function() {
			button.removeClass("hover");
			button.removeClass("size");
		}, 650);
		event.preventDefault();
	});

	// Shopping cart button
	$("#shoppingCartButton").on("click", function() {
		getShoppingCartProducts();

		if ($("#shoppingCart").hasClass("d-none")) {
			$("#shoppingCart").removeClass("d-none");
		} else {
			$("#shoppingCart").addClass("d-none");
		}
	});

	// Pay button
	$(".btn-next").click(function(){
		if (checkRequiredInputs()) {
			$(".nav-tabs .active").parent().next("li").find("a").trigger("click");
		}
	});

	// Check mark
	$("#product-klaar-tab").click(function () {
		setTimeout(function() {
			$(".payment-description").html("Processing payment...");
		}, 100);

		$.ajax({
			type: "POST",
			url: "inc/destroy.php"
		});

		setTimeout(function() {
			$(".payment-description").html("Payment received!");
			$(".circle-loader").toggleClass("load-complete");
			$(".checkmark").toggle();
		}, 3000);
	});

	// Pagination products per page
	$(".dropdownProducts").change(function(){
		$("form").submit();
	});

	// Shopping cart quantity input
	$("#quantityInput").change(function(){
		let quantityInput = $("#quantityInput").val();
		let id = $("#productId").val();
		let price = $("#productPrice").html().trim();
		let newTotalPrice = price * quantityInput;

		$("#totalPrice").html(newTotalPrice);

		$.ajax({
			type: "POST",
			url: "inc/add-to-cart.php",
			data: {
				id: id,
				quantity: quantityInput,
				price: newTotalPrice,
			}
		});
	});
});
