<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetUserList(currentPage){
		/* 
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
		*/
		$("#currentPage").val(currentPage);
		$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${requestScope.menu}").submit();
	};

	
	$(function() {
		
		$( "td.ct_btn01:contains('검색')" ).on("click", function() {
			alert("서연희\n" + $( "td.ct_btn01:contains('검색')" ).html());
			fncGetUserList('1');
		});




		$( ".ct_list_pop td:nth-child(5)" ).css("color" , "red");
		$( ".ct_list_pop td:nth-child(11)" ).css("color" , "green");
		
		$( ".ct_list_pop td:nth-child(5)" ).on("click", function() {
			var prodNo =$( $(this).parents("tr").children()[0] ).val();
			var proTranCode =$( $(this).parents("tr").children()[1] ).val();

			/* 
			if(proTranCode=='0' || proTranCode=='3') {
				self.location = "/product/getProduct?prodNo="+prodNo+"&menu=${ requestScope.menu }";
			}
			 */
			if(proTranCode=='0' || proTranCode=='3') {
				$.ajax(
						{
							url : "/product/json/getProduct/"+prodNo+"/${ requestScope.menu }",
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status) {
								
								var displayValue = "<h3>"
															+ "상품번호 : " + JSONData.product.prodNo + "<br/>"
															+ "상품 이름 : " + JSONData.product.prodName + "<br/>"
															+ "상품 이미지 : " + JSONData.product.fileName + "<br/>" 
															+ "상품 상세정보 : " + JSONData.product.prodDetail + "<br/>"
															+ "제조일자 : " + JSONData.product.manuDate + "<br/>"
															+ "가격 : " + JSONData.product.price + "<br/>"
															+ "등록일자 : " + JSONData.product.regDate + "<br/>"
															+ "</h3>";
															
								$("h3").remove();
								$( "#"+prodNo+"" ).html(displayValue);
								
							}
					});
			}
			
			
		});
		
		$( ".ct_list_pop td:nth-child(11)" ).on("click", function() {
			var prodNo =$( $(this).parents("tr").children()[0] ).val();
			var proTranCode =$( $(this).parents("tr").children()[1] ).val();


			self.location = "/purchase/updateTranCodeByProd?prodNo="+prodNo+"&tranCode=2";
		});
		
	});


</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
						<c:if test="${ ! empty requestScope.menu && requestScope.menu=='manage' }">
								상품 관리
						</c:if>
						<c:if test="${ ! empty requestScope.menu && requestScope.menu=='search' }">
								상품 목록조회
						</c:if>
					</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
				<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
				<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>상품가격</option>
			</select>
			<input type="text" name="searchKeyword"
						value="${! empty search.searchKeyword ? search.searchKeyword : ""}"
						class="ct_input_g" style="width:200px; height:19px" />
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						검색
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>


<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>	
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">

			<input type="hidden" class="prodNo" value="${product.prodNo}"/>
			<input type="hidden" class="proTranCode" value="${fn:trim(product.proTranCode)}"/>
		
			<td align="center">${ i }
			</td>
			<td></td>

			<td align="left">
				${ product.prodName }
			</td>

			<td></td>
			<td align="left">${ product.price}</td>
			<td></td>
			<td align="left">${ product.regDate}</td>
			<td></td>
			<td align="left">
			<c:if test="${ ! empty user.role && user.role=='admin' }">
				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='0' }">
					판매중
				</c:if>
				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='1' }">
					구매완료
					<c:if test="${ ! empty requestScope.menu && requestScope.menu=='manage' }">
						배송하기
					</c:if>
				</c:if>
				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='2' }">
					배송중
				</c:if>
				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='3' }">
					배송완료
				</c:if>
			</c:if>
			<c:if test="${ ! empty user.role && user.role!='admin' }">
				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)=='0' }">
					판매중
				</c:if>
 				<c:if test="${ ! empty product.proTranCode && fn:trim(product.proTranCode)!='0' }">
					재고없음
				</c:if>
			</c:if>
			<c:if test="${ empty user.role }">
				user.role이 empty!!!!!!!!!!!!!!
			</c:if>	
			</td>
		</tr>
		<tr>
		<!-- <td colspan="11" bgcolor="D6D7D6" height="1"></td> -->
		<td id="${product.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
		 	<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->

</form>

</div>
</body>
</html>