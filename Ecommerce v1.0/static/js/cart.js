$(document).ready(function(){
    $('#cartform').on('submit', function(event){
        $.ajax({
            data: {
                article_no: $('#article_no').val(),
                size: $('#size').val(),
                quantity: $('#quantity').val()
            },
            type: 'POST',
            url : '/shop/products/addtocart'
        })
        .done(function(data){
            if(data.error){
                $('#errorAlert').text(data.error).show();
                $('#successAlert').hide();
            }
            else {
                $('#successAlert').text(data.success).show();
                $('#errorAlert').hide();
            }
        });
        event.preventDefault();
    });

});