// retrieve get parameter
function findGetParameter(parameterName) {
    var result = null,
        tmp = [];
    location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
          tmp = item.split("=");
          if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        });
    return result;
}

// Start searching
function searchProduct() {
	let searchValue = $('#search').val().trim();
	let categoryValue = $('#category').val().trim();

	let searchResultBox = $("#searchResultsBox");
	searchResultBox.removeClass("d-none");

	if (!searchValue.trim()) {
		searchResultBox.addClass("d-none");
		searchResultBox.html("");
	} else {
		$.ajax({
			type: "POST",
			url: "inc/ajax.php",
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

$(document).ready(function () {
	// Enable tooltip
	$('[data-toggle="tooltip"]').tooltip();

	// Calculate product total price
	$(".quantity-input").change('change', function () {
		let totalCost = $("#productPrice").html() * $(this).val();
		$("#totalPrice").html(Math.round(totalCost * 100) / 100);
	});

	// Search when typing or category is changed
	$("#search").keyup(function () {
		searchProduct();
	});

	// $("#search").focusin(function () {
	// 	let searchResultBox = $("#searchResultsBox");
	// 	searchResultBox.removeClass("d-none");
	// });

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
		let quantityInput = $(".quantity-input").val();
		let cartCounter = $(".cart-counter").html().trim();
		let count = Number(cartCounter) + Number(quantityInput);
		let productName = $(".product-name").html().trim();
		let productPrice = $(".total-price-value").html().trim();
		var url = window.location.pathname;
		let id = findGetParameter('id');

		$.ajax({
			type: "POST",
			url: 'inc/add-to-cart.php',
			data: {
				name: productName,
				quantity: quantityInput,
				price: productPrice,
				id: id
			}
		});

		$("a.add-to-cart").addClass("size");
		setTimeout(function() {
			$("a.add-to-cart").addClass("hover");
		}, 200);
		setTimeout(function() {
			$(".cart-counter").text(count);
		}, 600);
		setTimeout(function() {
			$("a.add-to-cart").removeClass("hover");
			$("a.add-to-cart").removeClass("size");
		}, 650);
		event.preventDefault();
	});

	// Pay button
	$(".btn-next").click(function(){
		$('.nav-tabs .active').parent().next('li').find('a').trigger('click');
	});
});
