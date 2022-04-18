<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="common/adminheader.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<head>
<script type="text/javascript" src="${path}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${path}/js/jquery.form.min.js"></script>
<style>
	.a {border: solid red 5px}
	table {width: 100%}
	th, td {border: 1px gray solid;text-align: center;padding: 3px}
	h2 {text-align: left;}
	a {text-decoration: none;}
	a:hover {color: red}
	textarea{width:500px; height:500px; float: right;}
	input, select{
		border: solid gray 1px
		width: 250px;
	}
	form{
		width: 250px;
	}
	.col-sm-5 clearfix{
		position: absolute;
		float: right;
	}
	
</style>
<script type="text/javascript">
	$(function() {
		
		//전체검색
		function selectAll() {
			$.ajax({
				url : "${path}/ajax",
				type : "post",
				dataType : "json",
				data : {key : "ajaxGoods", methodName : "selectAll"},
				success : function(result) {
					let str = "";
					$.each(result, function(index, item) {
						str += "<tr>";
						str += "<td><a href='#'>" + item.goodsCode + "</a></td>";
						str += "<td>" + item.goodsType + "</td>";
						str += "<td>" + item.goodsName + "</td>";
						str += "<td>" + item.goodsPrice + "</td>";
						str += "<td>" + item.goodsStock + "</td>";
						str += "<td>" + item.isSoldout + "</td>";
						str += `<td><input type='button' value='이미지넣기'></td>`;
						str += `<td><input type='button' value='삭제'></td>`;
						str += "</tr>";
					});
					$("#goodstable tr:gt(0)").remove();
					$("#goodstable tr:eq(0)").after(str);

				},
				error : function(err) {
					alert(err + "에러 발생했습니다.");
				}
			}) //ajax
		}//selectAll 함수 끝

		/**
		상품 등록 + 수정
		 */
		$("#btn").click(function() {
			let state = true; //유효성 체크(true는 ajax하고, false는 ajax안한다.)
			
			$("input[type=text] ,[type=select]").each(function(index, item) { 
				if ($(this).val() == "") {
					alert("값을 모두 넣어주세요.");
					$(this).focus();

					state = false;
					return false; //return false의 의미 : each 함수를 빠져나가라.
				}
		
			
			});//상품 등록+수정 클릭 함수 끝
			
			

			if (state) { ////등록할때!
				 if ($(this).val == "수정") {
					$("[name=methodName]").val("insert"); //???????

					//버튼글씨 '등록' 변경,  readonly속성제거
					$("#btn").val("등록");
					$("#id").removeAttr("readonly");
				}  

				$.ajax({
					url : "${path}/ajax", //서버요청주소
					type : "post", //요청방식(method방식 : get | post | put | delete )
					dataType : "text", //서버가 보내온 데이터(응답)타입(text | html | xml | json )
					data : $('form').serialize(), //서버에게 보낼 데이터정보(parameter정보)
					success : function(result) {
						if (result == 0) {
							alert("실패하였습니다");
						} else {
						  
							//text내용 지우고 화면 갱신
							$("input[type=text] ,[type=select], [type=number]").val("");
							$("#goodsDetail").val("");
							selectAll();
							$("[name=methodName]").val("insert");
						}

					}, //성공했을때 실행할 함수 
					error : function(err) {
						alert(err + "에러 발생했습니다.");
					} //실패했을때 실행할 함수 
				}); //ajax끝
			}//if(state)끝

		});//click이벤트 끝
		
		
		//상품코드를 클릭했을 때 이벤트 처리
		$(document).on("click", function() {
			var goodsCode = document.getElementById("goodsCode"); //이름
			var goodsType = document.getElementById("goodsCode");
			var goodsName = document.getElementById("goodsCode");
			var goodsPrice = document.getElementById("goodsCode");
			var goodsStock = document.getElementById("goodsCode");
			var isSoldout = document.getElementById("goodsCode");
			
			//[object HTMLInputElement]
			alert(goodsCode);
			//text박스에 값넣기
			
			

			
			goodsCode.val($(this).text());
			/* $("#goodsType").val(goodsCode.text());
			$("#goodsName").val(goodsType.text());
			$("#goods").val(goodsName.text());
			$("#goodsStock").val(goodsPrice.text());
			$("#isSoldout").val(goodsStock.text());
			 */
			//goodsCode비활성화(입력불가능)
			$("#goodsCode").attr("readonly", "readonly");
			
			
			
			
			//btn의 글씨 수정로 변경
			$("#btn").val("수정");
		});

		selectAll();
	});//ready끝
</script>
</head>
<body>

	<section id="cart_items">
		<div class="container">

			<div class="step-one">
				<h2 class="heading">상품등록</h2>
			</div>
			
			<div class="shopper-informations">
				<div class="row">
					
					<div class="col-sm-3">
						<div class="shopper-info">
							<div class="form-one">
								<form name="goodsForm1" id="goodsForm1">
								<input type="text" name="goodsCode" id="goodsCode" placeholder="상품코드"> 
								<select name="goodsType" id="goodsType">
									<option>-- 상품타입 --</option>
									<option value="O">원두</option>
									<option value="D">드립백</option>
									<option value="C">캡슐</option>
								</select><br><br>
								<select name="isSoldout" id="isSoldout">
									<option>-- 품절여부 --</option>
									<option value="0">판매중</option>
									<option value="1">품절</option>
									<option value="2">판매중지</option>
								</select>
								
								</form>
							</div>
						</div>
					</div>
					
					<div class="col-sm-5 clearfix">
						<div class="bill-to">
							<div class="form-one">
								<form name="goodsForm2" id="goodsForm2">
								    <input type="text" name="goodsName" id="goodsName" placeholder="상품명"> 
									<input type="number" name="goodsPrice" id="goodsPrice" placeholder="상품가격"> 
									<input type="number" name="goodsStock" id="goodsStock" placeholder="상품수량"> 
								</form>
							</div>
						</div>
					</div>

							<div class="col-sm-4">
								<div class="order-message">
									<div class="form-one">
										<form name="goodsForm3" id="goodsForm3">
											<textarea name="goodsDetail" id="goodsDetail" placeholder="상품설명" rows="16"></textarea>
										</form>
									</div>
								</div>	
							</div>
							
							<div class="col-sm-4">
							<form name="goodsForm4" id="goodsForm4">
								<input type="hidden" name="key" value="ajaxGoods"> 
								<input type="hidden" name="methodName" value="insert">
								<input type="button" value="등록" id="btn"> 
								</form>
							</div>
							
							


						</div>
					</div>				
				</div>
			
			

			<div class="table-responsive cart_info">
				<table class="table table-condensed" id="goodstable">
					<tr class="goods_menu">
						<td class="goodsCode">상품코드</td>
						<td class="goodsType">상품타입</td>
						<td class="goodsName">상품명</td>
						<td class="goodsPrice">상품가격</td>
						<td class="goodsStock">상품재고</td>
						<td class="isSoldout">품절여부</td>
						<td class="addImg">이미지추가</td>
						<td class="isSoldout">삭제</td>
					</tr>
				</table>
			</div>
			
		
	</section> <!--/#cart_items-->

	

	
	


   <jsp:include page="common/adminfooter.jsp" />
</body>
</html>