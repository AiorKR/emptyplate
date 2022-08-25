$(".datepicker").change(function(){
	$("#viewUlTag").attr('style', "display:block;")
});

$(document).ready(function(){
    $('.datepicker').datepicker({
        format: 'yyyy-mm-dd',
        autoclose: true,
        startDate: '0d'
    });
    
    $('.dptime').click(function(){
        $('.dptime').removeClass('select');
        $(this).addClass('select');
        $("#viewUlTag").attr('style', "display:none;");
    });
    
    });