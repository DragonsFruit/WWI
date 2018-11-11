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

	$("#search").focusin(function () {
		let searchResultBox = $("#searchResultsBox");
		searchResultBox.removeClass("d-none");
	});

	$("#search").focusout(function () {
		let searchResultBox = $("#searchResultsBox");
		searchResultBox.addClass("d-none");
	});

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
});
