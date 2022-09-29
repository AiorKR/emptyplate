function remaindTime() {
    var now = new Date();
    var end = new Date(2022, 08, 16, 12, 00);

    var nt = now.getTime();
    var et1 = end.getTime();

    var endcheck1 = end.getFullYear() + '년 ' + end.getMonth() + '월 ' + end.getDate() + '일 ' + end.getHours() + '시' + end.getMinutes()    + '분'
  
   if(nt<et1){
    $(".time").fadeIn();
     $("p.time-title1").html("Today 마감까지");
     $("p.time-end1").html(endcheck1);
     sec =parseInt(et1 - nt) / 1000; 
     day  = parseInt(sec/60/60/24);
     sec = (sec - (day * 60 * 60 * 24));
     hour = parseInt(sec/60/60);
     sec = (sec - (hour*60*60));
     min = parseInt(sec/60);
     sec = parseInt(sec-(min*60));
     if(hour<10){hour="0"+hour;}
     if(min<10){min="0"+min;}
     if(sec<10){sec="0"+sec;}
      $(".hours").html(hour);
      $(".minutes").html(min);
      $(".seconds").html(sec);
    }

}
 setInterval(remaindTime,1000);