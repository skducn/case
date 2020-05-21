<!--#include file="md5.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="Inc/config.asp"-->

<!DOCTYPE html>
<html>
<head>
	<title><%=cstLogo%> | 登录页</title>
	
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
	<link rel="shortcut icon" href="favicon.ico"/>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/waves.min.css?v=0.7.6">		
	<script type="text/javascript" src="css/waves.min.js?v=0.7.6"></script>
	<script type="text/javascript" src="css/jquery.js"></script>
	<script type="text/javascript" src="css/prims.js"></script>	
</head>


<body>
<div id="bg-pattern" class="bg-pattern waves-effect waves-block waves-light"></div>
<div id="navigation" class="shadow"><a href="#examples"><%=cstCompany%></a></div>    
        
<div id="landing" class="section hide">
	<h1><%=cstLogo%></h1>
	<div class="button"><a href="#examples" class="waves-effect waves-button waves-float">Sign in </a><br><span>Welcome to Login</span></div>
</div>

<div id="example" class="section page hide">
	<h1>登录</h1>
	<div id="box-button" class="box shadow">
		<br>
		<form action="indexLogin.html" method="post" name="login" id="login">
			<table width="100%" border="0" align="center">
				<tr><td align="center" height="45"> <div class="search bar1"><input type="text" name="userName"  value="" size="25" placeholder="用户名"></div></td></tr>
				<tr><td align="center"><div class="search bar1"><input type="password" name="userPass"  value=""  size="25" placeholder="密码"></div></td></tr>
				<tr><td align="center">
					<br />
					<i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255); background: rgb(255, 79, 115)">
					<input name="submit2" type="submit" class="alert waves-button-input" style="background-color: rgba(0,0,0,0);" onClick="postFrom(this.form);" value="登录" href="#"></i>
					</td>
							
					<%if request("action") = "login" then
						userName = request("userName")
						userPass = md5(request("userPass")) 
						Set rs = Server.CreateObject("Adodb.Recordset")						
						rs.Open "select * from tbl_user where userName='"&userName&"' and userPass='"&userPass&"' and userStatus='1'",conn,3,3
						if not rs.eof then	   
							rs("latestLoginIp") = getUserIp()   'from function.asp
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
						end if    
						rs.close
						set rs = nothing
						conn.close
						set conn = nothing
					end if%>
				</tr>
			</table>     
		</form>
	</div>
</div>

</body>
</html>
