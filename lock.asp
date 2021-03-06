<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
<!--#include file="md5.asp"-->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<title>快速登录 | <%=cstProject%></title>
<link href="css/fontawesome.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link href="css/solid.css" rel="stylesheet">
</head>
<style>
input::-webkit-input-placeholder {
/* placeholder颜色  */
color: #aab2bd;
/* placeholder字体大小  */
font-size: 12px;
/* placeholder位置  */
text-align: left;
}
</style>
</head>

<%if request("action") = "login" then
	userPass = md5(request("userPass")) 
	userName = request("userName")
	latestLoginIp = request("latestLoginIp")
	Set rs = Server.CreateObject("Adodb.Recordset")						
	rs.Open "select * from tbl_user where userPass='"&userPass&"' and latestLoginIp='"&latestLoginIp&"' and userStatus='1'",conn,3,3
	if not rs.eof then	   
	rs("latestLoginDate") = now()
	rs.update
	session("userId") = rs("userId")
	session("userName") = rs("userName")
	session("userPower") = rs("userPower")
	if session("userPower") = 1 then   '管理员
	response.Redirect "admMain.html"
	elseif session("userPower") = 3 then  
	response.Redirect "tourist.html" ' 用例游客
	elseif session("userPower") = 4 then  
	response.Redirect "review.html"  ' 用例评审员
	else 
	response.Redirect "main.html"  '测试人员
	end if 
	else
	response.Write("<script>;alert('很抱歉，密码错误！');window.location.href='index.html';</script>")  
	end if    
	rs.close
	set rs = nothing
	conn.close
	set conn = nothing
end if%>


<body onLoad="document.getElementById('inputTxt').focus()">
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
			<div class="w3_info">
				<h2>欢迎使用<%=cstProject%></h2>
				<p>请登录您的账号</p>
				
				<form action="lockLogin.html" method="post" >
					<%
					Set rs4 = Server.CreateObject("Adodb.Recordset")						
					rs4.Open "select * from tbl_user where latestLoginIp='"&getClientIp()&"'",conn,3,3
					if not rs4.eof then		
					%>
					<div class="lock-box">
						<img src="<%=rs4("userImg")%>" class="img-circle user-image">	 
						<h3 class="text-center user-name"><%=rs4("userNickname")%></h3>
						<p class="text-center text-muted"><%=rs4("userTitle")%></p>
						<label>密码</label>
					<div class="input-group">
						<span class="fa fa-lock" aria-hidden="true"></span>
						<input type="Password" name="userPass" placeholder="请输入..." required="" id="inputTxt" maxlength="30"> 
					</div> 
						<input name="latestLoginIp" type="hidden" value="<%=getClientIp()%>" >
						<input name="userName2" type="hidden" value="<%=rs4("userName")%>" >		
						<button class="btn btn-danger btn-block" type="submit">快速登录</button>   
						<p class="account" align="right"><a href="indexClear-<%=rs4("userName")%>.html" class="lock11">我不是<%=rs4("userNickname")%>，切换账号</a></p>
						<%
						else
						response.Redirect("index.html")		
						end if 
						rs4.close
						set rs4 = nothing%>
					</div>
				</form>
	
				<p class="account">点击登录，同意与认可<a href="#"><%=cstProject%>使用规范</a></p>
				<p class="account1">我没有账号？<a href="mailto:h.jin@zy-healthtech.com">申请账号</a></p>
			</div>
		</div>
		<!-- //main content -->
	</div>
</div>
</body>
</html>

