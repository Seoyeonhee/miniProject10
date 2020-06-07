<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%-- <%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.*" %> --%>

<%-- <%
	List<Purchase> list = (List<Purchase>)request.getAttribute("list");
	Page resultPage = (Page)request.getAttribute("resultPage");
	
	Search search = (Search)request.getAttribute("search");

	//HashMap<String,Object> map=(HashMap<String,Object>)request.getAttribute("map");
	/*SearchVO searchVO=(SearchVO)request.getAttribute("searchVO");
	
	int total=0;
	ArrayList<Purchase> list=null;
	if(map != null){
		total=((Integer)map.get("count")).intValue();
		list=(ArrayList<Purchase>)map.get("list");
	}
	
	int currentPage=searchVO.getPage();
	
	int totalPage=0;
	if(total > 0) {
		totalPage= total / searchVO.getPageUnit() ;
		if(total%searchVO.getPageUnit() >0)
	totalPage += 1;
	}*/
%> --%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetUserList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/purchase/listPurchase" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">��ü <%-- <%= resultPage.getTotalCount() %> --%>${ resultPage.totalCount } �Ǽ�, ����  <%-- <%= resultPage.getCurrentPage() %> --%>${ resultPage.currentPage } ������</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%-- <%
		for(int i=0; i<list.size(); i++) {
		Purchase purchase = list.get(i);
	%> --%>
	
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center"><a href="/purchase/getPurchase?tranNo=<%-- <%= purchase.getTranNo() %> --%>${ purchase.tranNo }">${ i }</a></td>
			<td></td>
			<td align="left">
				<a href="/user/getUser?userId=<%-- <%= purchase.getBuyer().getUserId() %> --%>${ purchase.buyer.userId }"><%-- <%= purchase.getBuyer().getUserId() %> --%>${ purchase.buyer.userId }</a>
			</td>
			<td></td>
			<td align="left"><%-- <%= purchase.getReceiverName() %> --%>${ purchase.receiverName }</td>
			<td></td>
			<td align="left"><%-- <%= purchase.getReceiverPhone() %> --%>${ purchase.receiverPhone }</td>
			<td></td>
			<td align="left">����
						<%-- <% if(purchase.getTranCode().trim().equals("1")) { %>
							���ſϷ�
						<% } else if(purchase.getTranCode().trim().equals("2")) { %>
							�����
						<% } else if(purchase.getTranCode().trim().equals("3")) { %>
							��ۿϷ�
						<% } else { %>
							Error!!!!!!!!!!!!!!!!
						<% } %> --%>
				<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='1' }">
					���ſϷ�
				</c:if>
				<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
					�����
				</c:if>
				<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='3' }">
					��ۿϷ�
				</c:if>
				<c:if test="${ empty purchase.tranCode }">
					Error!!!!!!!!!!!!!!!!
				</c:if>
				���� �Դϴ�.
				<%-- <% if(purchase.getTranCode().trim().equals("2")) { %> --%>
				<c:if test="${ ! empty purchase.tranCode && fn:trim(purchase.tranCode)=='2' }">
					<a href="/purchase/updateTranCode?tranNo=<%-- <%= purchase.getTranNo() %> --%>${ purchase.tranNo }&tranCode=3">���ǵ���</a>
				</c:if>
				<%-- <% } %> --%>
			</td>
		</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<%-- <% } %> --%>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
		 	<%-- <% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %> --%>
		 	<jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>