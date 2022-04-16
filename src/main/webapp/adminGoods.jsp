<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="common/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <style>
		 .a{border:solid red 5px}
		 input{border:solid gray 1px}
		 table{width:100%}
		 th,td{border:1px gray solid; text-align:center;padding:3px}
		 h2{text-align:left;}
		 a{text-decoration: none;}
		 a:hover {color: red}
	</style>
    <script type="text/javascript">
    $(function(){
  	  
  	  /**
  	  	  전체 검색
  	  */
  	  function selectAll() {
  		  $.ajax({
  	   			url :"../ajax" , //서버요청주소
  	   			type:"post", //요청방식(method방식 : get | post | put | delete )
  	   			dataType:"json"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
  	   			data: {key:"goods", methodName:"selectAll"}, //서버에게 보낼 데이터정보(parameter정보)
  	   			success :function(result){
  	   				//alert(result)
  	   				let str ="";
  	   				$.each(result, function(index, item) {
  						str+="<tr>";
  						str+=`<td><a href="#">${item.goodsCode}</a></td>`;
  						str+=`<td>${item.goodsType}</td>`;
  						str+=`<td>${item.goodsName}</td>`;
  						str+=`<td>${item.goodsPrice}</td>`;
  						str+=`<td>${item.goodsStock}</td>`;
  						str+=`<td>${item.goodsDetail}</td>`;
  						str+=`<td>${item.isSoldout}</td>`;
  						str+=`<td>${item.goodsImg}</td>`;
  						str+=`<td><input type='button' value='삭제'></td>`;
  						str+="</tr>";
  					});
  	   				
  	   				$("#listTable tr:gt(0)").remove();
  	   				$("#listTable tr:eq(0)").after(str);
  	   				
  	   			} , //성공했을때 실행할 함수 
  	   			error : function(err){  
  	   				alert(err+"에러 발생했습니다.");
  	   			}  //실패했을때 실행할 함수 
  	   		});

  	}//selectAll 함수 끝
  	
  	  
  	/**
  		상품 등록 + 수정
  	*/
  	$("#btn").click(function() {
  		let state=true; //가입또는 수정을 할때 유효성 체크를 하고 ajax를 실행해도 되는지 여부를 판단하는 변수
  		//(true는 ajax하고, false는 ajax안한다.)
  		//유효성체크 필요 (값 존재 유무)
  		$("input[type=text]").each(function(index, item) { //item은 input element이다.
  			if($(this).val()==""){
  				alert("값을 입력해 주세요.");
  				$(this).focus(); //커서놓기
  				
  				state = false;
  				return false; //return false의 의미 : each 함수를 빠져나가라.
  			}
  		});
  		
  		if(state){
  			if($(this).val=="수정"){
  				$("[name=methodName]").val("insert");
  				
  				//버튼글씨 가입 변경,  readonly속성제거
  				$("#btn").val("가입");
  				
  				$("#GoodsCode").removeAttr("readonly");
  			}
  			
  			$.ajax({
  	   			url :"../ajax" , //서버요청주소
  	   			type:"post", //요청방식(method방식 : get | post | put | delete )
  	   			dataType:"text"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
  	   			data: $("#goodsForm").serialize(), //서버에게 보낼 데이터정보(parameter정보)
  	   			success :function(result){
  	   				if(result==0){
  	   					alert("실패하였습니다");
  	   				}else{
  	   					//text내용 지우고 화면 갱신
  	   					$("input[type=text]").val("");
  	   					selectAll();
  	   					$("[name=methodName]").val("insert");
  	   				}
  	   			
  	   			} , //성공했을때 실행할 함수 
  	   			error : function(err){  
  	   				alert(err+"에러 발생했습니다.");
  	   			}  //실패했을때 실행할 함수 
  	   		}); //ajax끝
  		}//if(state)끝
  		
  	});//click이벤트 끝
  	 
  	/*
		상품코드를 클릭했을 때 이벤트 처리
	*/
  	$(document).on("click", "#listTable > tbody > tr > td:nth-child(2) > a", function() {
  		//text박스에 값넣기
  		let goodsName = $(this).parent().next(); //이름이 있는 <tb>
  		let goodsPrice = goodsName.next(); //형제다음 element를 찾는다.
  		let goodsStock = goodsPrice.next();
  		let goodsDetail = goodsStock.next();
  		let isSoldout = goodsDetail.next();
  		let goodsImg = isSoldout.next();
  		
  		$("#goodsCode").val($(this).text());
  		$("#goodsName").val(goodsName.text());
  		$("#goodsPrice").val(goodsPrice.text());
  		$("#goodsStock").val(goodsStock.text());
  		$("#goodsDetail").val(goodsDetail.text());
  		$("#isSoldout").val(isSoldout.text());
  		$("#goodsImg").val(goodsImg.text());
  		
  		
  		$("#goodsCode").attr("readonly", "readonly");
  		
  		$("#btn").val("수정");
  	});
  	
  	/*
  		삭제하기
  	*/ 	
  /* 	$(document).on("click", "[value=삭제]", function() {
  		//alert($(this).attr("name"));
  		$.ajax({
     			url :"../ajax" , //서버요청주소
     			type:"post", //요청방식(method방식 : get | post | put | delete )
     			dataType:"text"  , //서버가 보내온 데이터(응답)타입(text | html | xml | json )
     			data: {key:"ajaxGoods", methodName:"delete", id : $(this).attr("name") }, //서버에게 보낼 데이터정보(parameter정보)
     			success :function(result){
     			
     			} , //성공했을때 실행할 함수 
     			error : function(err){  
     				alert(err+"에러 발생했어요.");
     			}  //실패했을때 실행할 함수 
     		}); //ajax끝
     		
  	}); */
  	   
  	selectAll();   
     });//ready끝
</script>
</head><!--/head-->
<body>

	<div class="GoodsView">
		<h2 class="heading">상품등록</h2>
	</div>
	
	<div class="shopper-informations">
				<div class="row">
					<div class="col-sm-3">
						<div class="shopper-info">
							<form name="goodsForm" method="post" id="goodsForm">
								<input type="text" name="goodsCode" id="goodsCode" placeholder="상품코드">
								<select name="goodsType" id="goodsType">
										<option>-- 상품타입 --</option>
										<option value="O">원두</option>
										<option value="D">드립백</option>
										<option value="C">캡슐</option>
								</select>
								<input type="text" name="goodsName" id="goodsName" placeholder="상품명">
								<input type="text" name="goodsPrice" id="goodsPrice" placeholder="상품가격">
								<input type="text" name="goodsStock" id="goodsStock" placeholder="상품수량">
								<select name="isSoldout" id="isSoldout">
										<option>-- 품절여부 --</option>
										<option value="0">품절</option>
										<option value="1">판매중</option>
										<option value="2">판매중지</option> <!-- 삭제 할 때. -->
								</select>
								<input type="text" name="goodsImg" id="goodsImg" placeholder="상품이미지">
							</form>
						</div>
					</div>
					
					<div class="col-sm-4">
						<div class="order-message">
							<textarea name="goodsDetail" id="goodsDetail" placeholder="상품설명" rows="15"></textarea>
						</div>	
					</div>
					
					<div class="col-sm-5">
							<input type="hidden" name="key" value="ajaxGoods">
							<input type="hidden" name="methodName" value="insert">
							<input type="button" value="등록"  id="btn">
							<input type="reset" value="지우기"  id="reset">
				    </div>						
				</div>
			</div>

	<div class="GoodsView">
		<h2 class="heading">상품조회</h2>
	</div>

	<div class="listTable" cellspacing="0">
		<table class="Goodstable">
			<thead>
				<tr class="goods_menu">
					<td class="goodsCode">상품코드</td>
					<td class="goodsType">상품타입</td>
					<td class="goodsName">상품명</td>
					<td class="goodsPrice">상품가격</td>
					<td class="goodsStock">상품재고</td>
					<td class="isSoldout">품절여부</td>
				</tr>
			</thead>
		</table>
	</div>

</body>
	<jsp:include page="common/footer.jsp"/>
</html>