<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
<!--#include file="md5.asp"-->


<% 
if request("action")="exit" then
Session.Abandon()
response.Redirect("index.html")
end if 
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>��¼ | <%=cstProject%></title>
<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
<link href="css/fontawesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/solid.css" rel="stylesheet">
<style>
input::-webkit-input-placeholder {
/* placeholder��ɫ  */
color: #aab2bd;
/* placeholder�����С  */
font-size: 12px;
/* placeholderλ��  */
text-align: left;
}
</style>
</head>



<!-- ��¼ -->
<%if request("action") = "login" then
	userName = request("userName")
	userPass = md5(request("userPass")) 
	Set rs = Server.CreateObject("Adodb.Recordset")						
	rs.Open "select * from tbl_user where userName='"&userName&"' and userPass='"&userPass&"' and userStatus='1'",conn,3,3
	if not rs.eof then	   
		rs("latestLoginIp") = getClientIp()   'from function.asp
		rs("latestLoginDate") = now()
		rs.update
		session("userId") = rs("userId")
		session("userName") = rs("userName")
		session("userPower") = rs("userPower")
		session("latestLoginIp") = getClientIp()
		if session("userPower") = 1 then   '����Ա
			response.Redirect "admMain.html"
		elseif session("userPower") = 3 then  
			response.Redirect "tourist.html" ' �����ο�
		elseif session("userPower") = 4 then  
			response.Redirect "review.html"  ' ��������Ա
		else 
			response.Redirect "main.html"  '������Ա
		end if 
	else
		response.Redirect("index.html")

	end if    
	rs.close
	set rs = nothing
	conn.close
	set conn = nothing
end if%>


<!-- �����¼IP -->	
<%if request("action") = "clear" then
userName = request("userName")
Set rs = Server.CreateObject("Adodb.Recordset")						
rs.Open "select * from tbl_user where userName='"&userName&"'",conn,3,3
if not rs.eof then	   
	rs("latestLoginIp") = ""
	rs.update
end if    
rs.close
set rs = nothing
conn.close
set conn = nothing
response.Redirect("index.html")
end if%>
	
<!-- ��ѯ��ǰ��¼IP�Ƿ��¼�������֮ǰ��¼�ģ�����תlock.htmlҳ�档 -->	
<%
Set rs = Server.CreateObject("Adodb.Recordset")						
rs.Open "select * from tbl_user where latestLoginIp='"&getClientIp()&"' and userStatus='1'",conn,3,3
if not rs.eof then	   
response.Redirect("lock.html")		
end if
rs.close
%>
	

<body onLoad="document.getElementById('inputTxt').focus()"> 	
<img src="images/book.png" width="3" height="3">
<div class="signupform">
	<div class="container">
		<!-- main content -->
		<div class="agile_info">
			<div class="w3l_form">
				<div class="left_grid_info">
					<h1><%=cstTitle%></h1>
					<p><%=cstIntro%></p><br>
					<img src="./images/index.png" alt="" >
					
				</div>
			</div>
			<div class="w3_info ">
				<h2>��ӭʹ��<%=cstProject%></h2>
				<p>���¼�����˺�</p>
				<form action="indexLogin.html" method="post">
					<label>�˺�</label>
					<div class="input-group">
						<span class="fa fa-user-alt" aria-hidden="true"></span>
						<input type="text" name="userName" placeholder="������..." required="" maxlength="20" id="inputTxt"> 
					</div>
					<label>����</label>
					<div class="input-group">
						<span class="fa fa-lock" aria-hidden="true"></span>
						<input type="Password" name="userPass" placeholder="������..." required="" maxlength="30"> 
					</div> 
					<div class="login-check">
						 <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i> ��ס��</label>
					</div>						
						<button class="btn btn-danger btn-block" type="submit" >��¼</button>                
				</form>
				<p class="account">�����¼��ͬ�����Ͽ�<a href="#"><%=cstProject%>ʹ�ù淶</a></p>
				<p class="account1">��û���˺ţ�<a href="mailto:h.jin@zy-healthtech.com">�����˺�</a></p>
				<p class="account1 fa fa-tasks" align="right"> <a href="http://<%=getServerIp()%>" target="_blank">CMS֪ʶ��</a></p>
			</div>
		</div>
		<!-- //main content -->
	</div>
</div>

<div class="footer-w3l" align="center"></div>
</body>
</html>



