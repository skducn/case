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
<meta charset="utf-8">
<link rel="shortcut icon" href=" /favicon.ico" /> 
<title>快速登录 | <%=cstProject%></title>
<link rel="stylesheet" type="text/css" href="731/dist/css/main.css">
</head>
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script> 
<script language="javascript">  
function CheckPost()
{	  
     if (addForm.userPass.value == "") 
	 {
		$.notify({
			title: "&nbsp;&nbsp;",
			message: "密码不能为空！",
			icon: 'fa fa-remove' 
		},{
			type: "danger"
		});
	  addForm.userName.focus();
	  return false;
  }
}
</script>

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
   <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="lockscreen-content">
			
      <div class="logo">
          <h1 align="center">测试用例平台</h1>
      </div>
	  
	    <%
		
		Set rs4 = Server.CreateObject("Adodb.Recordset")						
		rs4.Open "select * from tbl_user where latestLoginIp='"&getUserIp()&"'",conn,3,3
	
		%>
	  <form action="lockLogin.html" method="post" name="addForm"  class="login-form" onSubmit="return CheckPost()" >
      <div class="lock-box"><img class="img-circle user-image" src="<%=rs4("userImg")%>">
        <h3 class="text-center user-name"><%=rs4("userNickname")%></h3>
        <p class="text-center text-muted"><%=rs4("userTitle")%></p>
        <form class="unlock-form" action="index.html">
          <div class="form-group">
          <br>
            <input class="form-control" name="userPass" type="password" placeholder="password" id="inputTxt">
			<input name="latestLoginIp" type="hidden" value="<%=getUserIp()%>" >
			<input name="userName" type="hidden" value="<%=rs4("userName")%>" >
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block" type="submit"><h4><i class="fa fa-unlock fa-lg"></i> 快速登录</h4></button>
          </div>
        </form>
        <p><a href="indexClear-<%=rs4("userName")%>.html">我不是 <%=rs4("userNickname")%> ? 重新登录</a></p>
      </div>
    </section>
	<%rs4.close
	set rs4 = nothing%>

			
      </div>
    </section>
  </body>

</html>