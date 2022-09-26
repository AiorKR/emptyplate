<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html>

<head>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript">
window.onload = function () {
	const checkAll = document.getElementById('chkAll');
	const chks = document.querySelectorAll('.chk');  
	const chkBoxLength = chks.length;

	checkAll.addEventListener('click', function(event) {
	    if(event.target.checked)  {
	        chks.forEach(function(value){
	        value.checked = true;
	    })
	    }else {
	       chks.forEach(function(value){
	       value.checked = false;
	    })
	 }
	  });
	for (chk of chks){
	    chk.addEventListener('click', function() {
	        let count = 0;
	        chks.forEach(function(value){
	            if(value.checked == true){
	                count++;
	            }
	        })
	        if(count !== chkBoxLength){
	            checkAll.checked = false;
	        }else{
	            checkAll.checked = true;
	        }
	      })
	}
	 }
	
function agree_chk(){	
	if($("#agree1").is(":checked") == true){
		console.log("체크된상태");
		if($("#agree2").is(":checked") == true){
			console.log("체크된상태");
			self.close();
			}
		else
		{
			console.log("체크안된상태");
			alert("필수약관에 동의해주세요.");
			return;
		}	
	}
	else{
		console.log("체크안된상태");
		alert("필수약관에 동의해주세요.");
		return;
	}	
}
</script>

<style>

h1{
  color: #333;
  border-bottom: 4px solid #a79600;
  padding-bottom: 5px;
  position: relative;
}

h1:before{
/*     content: '';
    position: absolute;
    bottom: -20px;
    left: 50%;
    width: 20px;
    height: 20px;
    background: white;
    border-left: 4px solid #a79600;
   */
  content: ' ';
  position: absolute;
  width: 0;
  height: 0;
  left: 30px;
  bottom: -30px;
  border: 15px solid;
  border-color: #a79600 transparent transparent #a79600;
}

h1:after{
/*     content: '';
    position: absolute;
    bottom: -20px;
    left: 49%;
    width: 15px;
    height: 31px;
    transform: rotate(51deg);
    border-right: 4px solid #a79600; */
    
  content: ' ';
  position: absolute;
  width: 0;
  height: 0;
  left: 34px;
  bottom: -20px;
  border: 15px solid;
  border-color: #fff transparent transparent #fff;
}

*{margin: 0;padding: 0;box-sizing: border-box}
body{background-color: #f7f7f7;}
ul>li{list-style: none}
a{text-decoration: none;}
.clearfix::after{content: "";display: block;clear: both;}
#joinForm{width: 460px;margin: 0 auto;}
ul.join_box{border: 1px solid #ddd;background-color: #fff;}
.checkBox,.checkBox>ul{position: relative;}
.checkBox>ul>li{float: left;}
.checkBox>ul>li:first-child{width: 85%;padding: 15px;font-weight: 600;color: #888;}
.checkBox>ul>li:nth-child(2){position: absolute;top: 50%;right: 30px;margin-top: -12px;}
.checkBox textarea{width: 96%;height: 90px; margin: 0 2%;background-color: #f7f7f7;color: #888; border: none;}
.footBtwrap{margin-top: 15px;}.footBtwrap>li{float: left;width: 50%;height: 60px;}
.footBtwrap>li>button{display: block; width: 100%;height: 100%; font-size: 20px;text-align: center;line-height: 60px;}
.fpmgBt1{background-color: #fff;color:#888}
.fpmgBt2{background-color: lightsalmon;color: #fff}

</style>
</head>

<body>
<div style="text-align: center;">
<h1>Empty Plate 회원약관</h1>
<br />
</div>
    <form action="" id="joinForm">
        <ul class="join_box">
            <li class="checkBox check01">
                <ul class="clearfix">
                    <li>이용약관, 개인정보 수집 및 이용,
                        위치정보 이용약관(선택), 프로모션 안내
                        메일 수신(선택)에 모두 동의합니다.</li>
                    <li class="checkAllBtn">
                        <input type="checkbox" name="chkAll" id="chkAll" class="chkAll">
                    </li>
                </ul>
            </li>
            <li class="checkBox check02">
                <ul class="clearfix">
                    <li>이용약관 동의(필수)</li>
                    <li class="checkBtn">
                        <input type="checkbox" name="chk" class="chk" id="agree1"> 
                    </li>
                </ul>
                <textarea name="" id="">여러분을 환영합니다.
엠프티플레이트 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 엠프티플레이트 서비스의 이용과 관련하여 엠프티플레이트 서비스를 제공하는 엠프티플레이트 주식회사(이하 ‘엠프티플레이트’)와 이를 이용하는 엠프티플레이트 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 엠프티플레이트 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
   </textarea>
            </li>
            <li class="checkBox check03">
                <ul class="clearfix">
                    <li>개인정보 수집 및 이용에 대한 안내(필수)</li>
                    <li class="checkBtn">
                        <input type="checkbox" name="chk" class="chk" id="agree2">
                    </li>
                </ul>

                <textarea name="" id="">여러분을 환영합니다.
엠프티플레이트 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 엠프티플레이트 서비스의 이용과 관련하여 엠프티플레이트 서비스를 제공하는 엠프티플레이트 주식회사(이하 ‘엠프티플레이트’)와 이를 이용하는 엠프티플레이트 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 엠프티플레이트 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
   </textarea>
            </li>
            <li class="checkBox check03">
                <ul class="clearfix">
                    <li>위치정보 이용약관 동의(선택)</li>
                    <li class="checkBtn">
                        <input type="checkbox" name="chk" class="chk">
                    </li>
                </ul>

                <textarea name="" id="">여러분을 환영합니다.
엠프티플레이트 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 엠프티플레이트 서비스의 이용과 관련하여 엠프티플레이트 서비스를 제공하는 엠프티플레이트 주식회사(이하 ‘엠프티플레이트’)와 이를 이용하는 엠프티플레이트 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 엠프티플레이트 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
   </textarea>
            </li>
            <li class="checkBox check04">
                <ul class="clearfix">
                    <li>이벤트 등 프로모션 알림 메일 수신(선택)</li>
                    <li class="checkBtn">
                        <input type="checkbox" name="chk" class="chk">
                    </li>
                </ul>

            </li>
        </ul>
        <ul class="footBtwrap clearfix">
            <li><button class="fpmgBt1">비동의</button></li>
            <li><button class="fpmgBt2" onclick="agree_chk()" id="agree">동의</button></li>
        </ul>
    </form>
</body>

</html>