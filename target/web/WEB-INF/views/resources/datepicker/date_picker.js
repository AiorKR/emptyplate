$(".personnel-selected-value").click(function(){
  $("#select-ul").attr('style', "display:inline-block;");
});

$(".menu").click(function(){
  $('#menu1').is(':checked') ? $("#menu1Quantity").attr('disabled', false) : $("#menu1Quantity").attr('disabled', true) && $("#menu1Quantity").val(null);
  $('#menu2').is(':checked') ? $("#menu2Quantity").attr('disabled', false) : $("#menu2Quantity").attr('disabled', true) && $("#menu2Quantity").val(null);
  $('#menu3').is(':checked') ? $("#menu3Quantity").attr('disabled', false) : $("#menu3Quantity").attr('disabled', true) && $("#menu3Quantity").val(null);
  $('#menu4').is(':checked') ? $("#menu4Quantity").attr('disabled', false) : $("#menu4Quantity").attr('disabled', true) && $("#menu4Quantity").val(null);
});

$(".option").click(function(){
  $('.option').removeClass('select');
  $(this).addClass('select');
  $("#select-ul").attr('style', "display:none;");
  $(".personnel-selected-value").text($(this).text());
  // $(".datepicker").attr('style', "display:inline;");
});

$(".datepicker").change(function(){
	$("#datepicker-ul").attr('style', "display:inline;");
});



$(document).ready(function(){
    $('.datepicker').datepicker({
		format: 'yyyy.mm.dd',
		autoclose: true,
		startDate: '0d',
		endDate: '+1m'
    });
    
    $('.dptime').click(function(){
      $('.dptime').removeClass('select');
      $(this).addClass('select');
      $("#datepicker-ul").attr('style', "display:none;");
		$('.datepicker').val($('.datepicker').val()+ ' ' + $(this).text());
    });
    
    });