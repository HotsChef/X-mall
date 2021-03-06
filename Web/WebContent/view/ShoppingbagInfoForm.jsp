<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "jsp.include.model.IncludeDAO" %>
<%@ page import = "jsp.include.model.IncludeBean" %>
<%@ page import = "jsp.item.model.ItemBean" %>
<%@ page import = "jsp.item.model.ItemDAO" %>
<%@ page import = "jsp.manage.model.ManageBean" %>
<%@ page import = "jsp.manage.model.ManageDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.util.List" %>
    
<%
	String bagId = request.getParameter("bagId");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>쇼핑백 정보</title>
		<style>
			table {
				margin-left:auto;
				margin-right:auto;
				width:700px;
				border:3px solid skyblue;
			}
			td {
				border:1px solid skyblue;
			}
			#title {
				background-color:skyblue;
			}
			#content{
				background-color:white;
			}
			#warn {
				background-color:red;
			}
		</style>
		<script type="text/javascript">
			function changeForm(val) {
				if (val == "-1") {
					location.href="MainForm.jsp?contentPage=view/ShoppingbaglistForm.jsp"
				} else {
					location.href = "MainForm.jsp?contentPage=view/OrderShoppingbagForm.jsp?bagId=" + val;
				}
			}
			function deleteForm(val) {
				location.href="MainForm.jsp?contentPage=pro/DeleteShoppingbagPro.jsp?bagId=" + val;
			}
			
			function editForm(val) {
				var bid = <%=bagId %>
				location.href="MainForm.jsp?contentPage=view/EditItemForm.jsp?word=" + bid + "+" + val;
			}
		</script>
	</head>
	<body>
		<%
			// 장바구니가 포함하고 있는 아이템들을 가져옴
			IncludeDAO idao = IncludeDAO.getInstance();
			List<IncludeBean> ilist = new ArrayList<IncludeBean>();
			ilist = idao.getIncludeList(Integer.parseInt(bagId));
			
			// 해당하는 아이템 정보
			ItemDAO itdao = ItemDAO.getInstance();
			ManageDAO mdao = ManageDAO.getInstance();
		%>
		<br><br>
		<b><font size="6" color="gray"><%=bagId %> - 장바구니 정보</font></b>
		<br><br>
		<table>
			<tr id = "title">
				<td>상품 번호</td>
				<td>상품 이름</td>
				<td>가격</td>
				<td>재고</td>
				<td>주문가능재고</td>
				<td>총가격(원)</td>
			</tr>
			<%
				int listSize = ilist.size();
				int total = 0;
				boolean warn = false;
				for (int i = 0; i < listSize; i++) {
					int item_id = ilist.get(i).getItem_id();
					ItemBean item = itdao.getItem(item_id);
					String item_name = item.getName();
					int item_price = item.getPrice();
					int stock = ilist.get(i).getStock();
					int totalStock = mdao.getStock(item_id);
					total += item_price*stock;
					if (totalStock < stock) { warn=true;
			%>
					<tr id = "warn" onclick = "editForm(<%=item_id %>)" style="cursor:pointer">
					<% } else { %>
					<tr id = "content" onclick = "editForm(<%=item_id %>)" style="cursor:pointer">
					<% } %>
						<td><%=item_id %></td>
						<td><%=item_name %></td>
						<td><%=item_price %></td>
						<td><%=stock %></td>
						<td><%=totalStock %>
						<td><%=item_price * stock %></td>
					</tr>
			<%  } %>
			<% if (total == 0) warn = true; %>
			<tr id = "content">
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td><%=total %></td>
			</tr>
		</table>
		<input type="button" value="장바구니로" onclick = "changeForm(-1)" style="cursor:pointer">
		<% if (warn == false) {%>
			<input type="button" value="구매하기" onclick = "changeForm(<%=bagId %>)" style="cursor:pointer">
		<% } %>
		<input type="button" value="삭제하기" onclick="deleteForm(<%=bagId %>)" style="cursor:pointer">
	</body>
</html>