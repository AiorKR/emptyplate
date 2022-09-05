$(".personnel-selected-value").click(function(){
  $("#select-ul").attr('style', "display:inline-block;");
});

$(".option").click(function(){
  $('.option').removeClass('select');
  $(this).addClass('select');
	  $("#select-ul").attr('style', "display:none;");
	  $(".personnel-selected-value").text($(this).text());
	  document.bbsForm.reservationPeople.value = $(".personnel-selected-value").text();
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
      document.bbsForm.reservationDate.value = $('.datepicker').val().replaceAll(".", "");
      document.bbsForm.reservationTime.value = $(this).text();
      document.bbsForm.reservationTime.value = $(this).text().replaceAll(":", "");
	  $('.datepicker').val($('.datepicker').val()+ ' ' + $(this).text());
	  
    });
});