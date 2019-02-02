$(function(){
    $('#email_text').bind('keydown keyup keypress change',function(){
        var thisValueLength = $(this).val().length;
        $('.email_count').html(thisValueLength);
    });
});

$(function(){
    $('#password_text').bind('keydown keyup keypress change',function(){
        var thisValueLength = $(this).val().length;
        $('.password_count').html(thisValueLength);
    });
});