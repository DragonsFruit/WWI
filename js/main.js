//Getting value from "ajax.php".
function fill(Value) {
    //Assigning value to "search" div in "search.php" file.
    $('#search').val(Value);

    //Hiding "display" div in "search.php" file.
    $('#display').hide();
}

$(document).ready(function () {
	// Enable tooltip
    $('[data-toggle="tooltip"]').tooltip();

    // Calculate product total price
    $(".quantity-input").change('change', function () {
        let totalCost = $("#product-price").html() * $(this).val();
        $("#total-price").html(Math.round(totalCost * 100) / 100);
    });

    // On pressing a key on "Search box" in "search.php" file. This function will be called.
    $("#search").keyup(function () {
        //Assigning search box value to javascript variable named as "name".
        let name = $('#search').val().trim();
        let searchResultBox = $("#serachResults");
	    searchResultBox.removeClass("d-none");

        //Validating, if "name" is empty.
        if (!name.trim()) {
            //Assigning empty value to "display" div in "search.php" file.
	        searchResultBox.addClass("d-none");
	        searchResultBox.html("");
        } else {
            //AJAX is called.
            $.ajax({
                type: "POST",
                url: "inc/ajax.php",
                data: {
                    search: name
                },
                success: function (html) {
                    //Assigning result to "display" div in "search.php" file.
	                searchResultBox.html(html).show();
                }
            });
        }
    });
});
