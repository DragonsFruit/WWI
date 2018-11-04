$(function () {
    $('[data-toggle="tooltip"]').tooltip();

    $(".quantity-input").change('change',function(){
        var totalcost= $("#product-price").html() * $(this).val();
        $("#total-price").html(Math.round(totalcost * 100) / 100);
    });
});
