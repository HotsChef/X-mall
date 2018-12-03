<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "jsp.item.model.ItemBean" %>
<%@ page import = "jsp.item.model.ItemDAO" %>
<%@ page import = "jsp.producerlocation.model.ProducerlocationBean" %>
<%@ page import = "jsp.producerlocation.model.ProducerlocationDAO" %>
<%@ page import = "jsp.manage.model.ManageBean" %>
<%@ page import = "jsp.manage.model.ManageDAO" %>
<%@ page import = "java.util.StringTokenizer" %>
<% 
	String word = request.getParameter("word");
	StringTokenizer st = new StringTokenizer(word);
	String bagId = st.nextToken();
	String itemId = st.nextToken();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>ǰ�� ����</title>
		
		<style>
			table {
				margin-left:auto;
				margin-right:auto;
				width:600px;
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
		</style>
		
		<script type="text/javascript">
			function changeForm(val) {
				if (val == "-1") {
					location.href="MainForm.jsp?contentPage=view/ShoppingbaglistForm.jsp"
				} else if (val == "-2") {
					var lk = document.getElementById("oc").value;
					if (!lk) lk = 0;
					var id = <%=itemId %>
					var bid = <%=bagId %>
					location.href = "MainForm.jsp?contentPage=pro/EditItemPro.jsp?word=" + bid + "+" + id + "+" + lk;
				}
			}
		</script>
	</head>
	
	<body>
		<%
			// ��ȣ�� �´� ��ǰ�� ã�ƿ�
			ItemDAO idao = ItemDAO.getInstance();
			ItemBean item = idao.getItem(Integer.parseInt(itemId));
			// ��ȣ�� �´� �����ڸ� ã�ƿ�
			ProducerlocationDAO pdao = ProducerlocationDAO.getInstance();
			ProducerlocationBean pd = pdao.getItemToProducer(Integer.parseInt(itemId));
			// ��ȣ�� �´� �������� ����� �˻���
			ManageDAO mdao = ManageDAO.getInstance();
		%>
		<br><br>
		<b><font size="6" color="gray">��ǰ ����</font></b>
		<br><br>
		<table>
			<tr>
				<td id = "title">��ǰ ��ȣ</td>
				<td id = "content"><%=item.getItem_id() %></td>
			</tr>
			<tr>
				<td id = "title">��ǰ �̸�</td>
				<td id = "content"><%=item.getName() %></td>
			</tr>
			<tr>
				<td id = "title">����</td>
				<td id = "content"><%=item.getPrice() %>��</td>
			</tr>
			<tr>
				<td id = "title">������</td>
				<td id = "content"><%=item.getDiscount_rate() %>%</td>
			</tr>
			<tr>
				<td id = "title">�������</td>
				<td id = "content">
					<%=item.getYear() %>��
					<%=item.getMonth() %>��
					<%=item.getDay() %>��
				</td>
			</tr>
			<tr>
				<td id = "title">����</td>
				<td id = "content"><%=item.getRating() %></td>
			</tr>
			<tr>
				<td id = "title">������</td>
				<td id = "content"><%=pd.getProducer() %></td>
			</tr>
			<tr>
				<td id = "title">�Ǹ���</td>
				<td id = "content"><%=item.getImporter() %></td>
			</tr>
			<tr>
				<td id = "title">���</td>
				<td id = "content"><%=mdao.getStock(Integer.parseInt(itemId)) %>��</td>
			</tr>
			<tr>
				<td id="title">���Ű���</td>
				<td id = "content">
					<input type="number" id = "oc" name="oc" min = "0" max=<%=mdao.getStock(Integer.parseInt(itemId)) %>>
				</td>
			</tr>
		</table>
		<input type="button" value="��ٱ��Ϸ�" onclick="changeForm(-1)">
		<input type="button" value="�����ϱ�" onclick="changeForm(-2)">
	</body>
</html>