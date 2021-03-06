<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import="jsp.customer.model.CustomerBean" %>
<%@ page import="jsp.customer.model.CustomerDAO" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원가입 처리 JSP</title>
		<link href='css/join_style.css' rel='stylesheet' style='text/css'>
		
		<script type="text/javascript">
			function goMainForm() {
				location.href="../MainForm.jsp";
			}
		</script>
	</head>
	<body>
		<%
			request.setCharacterEncoding("euc-kr");
		%>
		<jsp:useBean id="customerBean" class="jsp.customer.model.CustomerBean"/>
		<jsp:setProperty property="*" name="customerBean"/>
		
		<%
			CustomerDAO dao = CustomerDAO.getInstance();
		
			dao.insertCustomer(customerBean);
		%>
		
		<div id="wrap">
			<br><br>
			<b><font size="5" color="gray">회원가입 정보를 확인하세요.</font></b>
			<br><br>
			<font color="blue"><%=customerBean.getUser_id() %></font>님 가입을 축하드립니다.
			<table>
				<tr>
					<td id="title">아이디</td>
					<td><%=customerBean.getUser_id() %></td>
				</tr>
				<tr>
					<td id="title">비밀번호</td>
					<td><%=customerBean.getUser_password() %></td>
				</tr>
				<tr>
					<td id="title">주소</td>
					<td><%=customerBean.getAddress() %></td>
				</tr>
				<tr>
					<td id="title">휴대전화</td>
					<td><%=customerBean.getPhone_number() %></td>
				</tr>
				<tr>
					<td id="title">성별</td>
					<td><%=customerBean.getSex() %></td>
				</tr>
				<tr>
					<td id="title">나이</td>
					<td><%=customerBean.getAge()==0 ? 0 : customerBean.getAge() %></td>
				</tr>
				<tr>
					<td id="title">직업</td>
					<td><%=customerBean.getJob()==null ? "privacy" : customerBean.getJob() %></td>
				</tr>
			</table>
			
			<br>
			<input type="button" value="확인" onclick="goMainForm()">
		</div>
	</body>
</html>